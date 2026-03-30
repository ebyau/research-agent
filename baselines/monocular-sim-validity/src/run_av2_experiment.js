const fs = require('fs');
const path = require('path');
const parquet = require('parquetjs-lite');

function mulberry32(a) {
  return function() {
    let t = a += 0x6D2B79F5;
    t = Math.imul(t ^ t >>> 15, t | 1);
    t ^= t + Math.imul(t ^ t >>> 7, t | 61);
    return ((t ^ t >>> 14) >>> 0) / 4294967296;
  }
}

function randn(rng) {
  let u = 0, v = 0;
  while (u === 0) u = rng();
  while (v === 0) v = rng();
  return Math.sqrt(-2.0 * Math.log(u)) * Math.cos(2.0 * Math.PI * v);
}

async function loadScenario(file) {
  const reader = await parquet.ParquetReader.openFile(file);
  const cursor = reader.getCursor();
  const rows = [];
  let row;
  while ((row = await cursor.next())) {
    if (row.object_type !== 'vehicle') continue;
    rows.push({
      track_id: row.track_id,
      timestep: Number(row.timestep),
      x: Number(row.position_x),
      y: Number(row.position_y),
      vx: Number(row.velocity_x),
      vy: Number(row.velocity_y),
      scenario_id: row.scenario_id,
    });
  }
  await reader.close();
  return rows;
}

function groupByTime(rows) {
  const byTime = new Map();
  for (const r of rows) {
    if (!byTime.has(r.timestep)) byTime.set(r.timestep, []);
    byTime.get(r.timestep).push(r);
  }
  return byTime;
}

function computeMetrics(byTime, threshold=2.0, ttcThreshold=3.0, distThreshold=20.0) {
  let near = 0, ttc = 0, conflict = 0;
  let minDist = Infinity, activePairs = 0;
  for (const pts of byTime.values()) {
    for (let i=0;i<pts.length;i++) for (let j=i+1;j<pts.length;j++) {
      const dx = pts[i].x-pts[j].x, dy = pts[i].y-pts[j].y;
      const dvx = pts[i].vx-pts[j].vx, dvy = pts[i].vy-pts[j].vy;
      const dist = Math.hypot(dx,dy);
      minDist = Math.min(minDist, dist);
      if (dist < threshold) near++;
      if (dist < 5.0) conflict++;
      if (dist <= distThreshold) activePairs++;
      if (dist > distThreshold) continue;
      const closing = - (dx*dvx + dy*dvy) / Math.max(dist,1e-6);
      if (closing <= 0) continue;
      const ttcVal = dist / closing;
      if (ttcVal < ttcThreshold) ttc++;
    }
  }
  return { near, ttc, conflict, minDist: Number.isFinite(minDist) ? minDist : null, activePairs };
}

function perturb(rows, cfg, seed) {
  const rng = mulberry32(seed);
  const dropTracks = new Set();
  const tracks = [...new Set(rows.map(r=>r.track_id))];
  for (const t of tracks) if (rng() < cfg.dropTrackProb) dropTracks.add(t);
  return rows
    .filter(r => !dropTracks.has(r.track_id))
    .map(r => ({
      ...r,
      x: r.x + randn(rng) * cfg.posStd,
      y: r.y + randn(rng) * cfg.posStd,
      vx: r.vx + randn(rng) * cfg.velStd,
      vy: r.vy + randn(rng) * cfg.velStd,
    }));
}

async function main() {
  const root = path.resolve(__dirname, '..');
  const dataDir = path.resolve(root, '..', '..', 'data', 'av2_subset');
  const files = fs.readdirSync(dataDir).filter(f => f.endsWith('.parquet')).slice(0, 100);
  const conditions = {
    mild: { posStd: 0.25, velStd: 0.1, dropTrackProb: 0.01 },
    medium: { posStd: 0.75, velStd: 0.25, dropTrackProb: 0.03 },
    severe: { posStd: 1.5, velStd: 0.5, dropTrackProb: 0.08 },
  };
  const agg = { scenarios: files.length, baseline: { near: 0, ttc: 0, conflict: 0, minDist: Infinity, activePairs: 0 }, conditions: {} };
  for (const k of Object.keys(conditions)) agg.conditions[k] = { near: 0, ttc: 0, conflict: 0, minDist: Infinity, activePairs: 0 };

  for (let i=0;i<files.length;i++) {
    const rows = await loadScenario(path.join(dataDir, files[i]));
    const base = computeMetrics(groupByTime(rows));
    agg.baseline.near += base.near;
    agg.baseline.ttc += base.ttc;
    agg.baseline.conflict += base.conflict;
    agg.baseline.activePairs += base.activePairs;
    agg.baseline.minDist = Math.min(agg.baseline.minDist, base.minDist ?? Infinity);
    for (const [name, cfg] of Object.entries(conditions)) {
      const pert = computeMetrics(groupByTime(perturb(rows, cfg, 1000+i)));
      agg.conditions[name].near += pert.near;
      agg.conditions[name].ttc += pert.ttc;
      agg.conditions[name].conflict += pert.conflict;
      agg.conditions[name].activePairs += pert.activePairs;
      agg.conditions[name].minDist = Math.min(agg.conditions[name].minDist, pert.minDist ?? Infinity);
    }
  }

  const results = {
    scenarios: agg.scenarios,
    baseline: agg.baseline,
    conditions: Object.fromEntries(Object.entries(agg.conditions).map(([k,v]) => [k, {
      near: v.near,
      ttc: v.ttc,
      conflict: v.conflict,
      minDist: v.minDist,
      activePairs: v.activePairs,
      delta_near: v.near - agg.baseline.near,
      delta_ttc: v.ttc - agg.baseline.ttc,
      delta_conflict: v.conflict - agg.baseline.conflict,
      delta_activePairs: v.activePairs - agg.baseline.activePairs,
    }]))
  };
  const out = path.join(root, 'artifacts', 'av2_perturbation_results.json');
  fs.mkdirSync(path.dirname(out), { recursive: true });
  fs.writeFileSync(out, JSON.stringify(results, null, 2));
  console.log(JSON.stringify(results, null, 2));
}

main().catch(err => { console.error(err); process.exit(1); });
