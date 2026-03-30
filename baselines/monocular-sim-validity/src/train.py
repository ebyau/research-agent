import json
from pathlib import Path

from data import make_synthetic_scene, save_scene
from model import reconstruct_with_noise
from evaluate import summarize, save_results


def main():
    root = Path(__file__).resolve().parents[1]
    config = json.loads((root / 'configs' / 'pilot.json').read_text())
    artifacts = root / 'artifacts'
    artifacts.mkdir(exist_ok=True)

    gt_scene = make_synthetic_scene(config['num_agents'], config['num_steps'], config['seed'])
    recon_scene = reconstruct_with_noise(
        gt_scene,
        position_std=config['noise']['position_std'],
        velocity_std=config['noise']['velocity_std'],
        seed=config['seed'],
    )

    save_scene(artifacts / 'synthetic_scene.json', gt_scene)
    results = summarize(gt_scene, recon_scene)
    save_results(artifacts / 'pilot_results.json', results)
    print(results)


if __name__ == '__main__':
    main()
