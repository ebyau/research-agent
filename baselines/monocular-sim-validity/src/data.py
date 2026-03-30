import json
import random
from pathlib import Path


def make_synthetic_scene(num_agents=5, num_steps=20, seed=7):
    rng = random.Random(seed)
    scene = []
    for agent_id in range(num_agents):
        x, y = rng.uniform(0, 20), rng.uniform(0, 20)
        vx, vy = rng.uniform(-1, 1), rng.uniform(-1, 1)
        traj = []
        for t in range(num_steps):
            x += vx + rng.gauss(0, 0.05)
            y += vy + rng.gauss(0, 0.05)
            traj.append({"t": t, "x": x, "y": y, "vx": vx, "vy": vy})
        scene.append({"agent_id": agent_id, "trajectory": traj})
    return scene


def save_scene(path, scene):
    Path(path).write_text(json.dumps(scene, indent=2))
