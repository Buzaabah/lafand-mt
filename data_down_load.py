#import os

from datasets import load_dataset

dataset_dir = "datasets"
#os.makedirs(save_dir, exist_ok=True)

#save_path = os.path.join(os.getcwd(), save_dir)

dataset = load_dataset("castorini/wura", data_dir=dataset_dir)

#for split in dataset.keys():
#    dataset[split].save_to_disk(os.path.join(save_path, split))

print(f"WURA dataset downloaded and saved to: {dataset_dir}")
