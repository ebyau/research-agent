import copy
import random


def reconstruct_with_noise(scene, position_std=0.4, velocity_std=0.2, seed=7):
    rng = random.Random(seed)
    noisy = copy.deepcopy(scene)
    for agent in noisy:
        for p in agent["trajectory"]:
            p["x"] += rng.gauss(0, position_std)
            p["y"] += rng.gauss(0, position_std)
            p["vx"] += rng.gauss(0, velocity_std)
            p["vy"] += rng.gauss(0, velocity_std)
    return noisy
