from datasets import load_dataset

# Get the current working directory
import os
current_dir = os.getcwd()

# Define the path to the datasets directory (within current working directory)
dataset_dir = os.path.join(current_dir, "datasets")

# Load the WURA dataset from huggingface
dataset = load_dataset("castorini/wura", data_dir=dataset_dir)

print(f"WURA dataset downloaded and saved to: {dataset_dir}")

