import os

from datasets import load_dataset

save_dir = "datasets"
os.makedirs(save_dir, exist_ok=True)

save_path = os.path.join(os.getcwd(), save_dir)

dataset = load_dataset("castorini/wura", output_path=save_path, verification_mode="no_checks")