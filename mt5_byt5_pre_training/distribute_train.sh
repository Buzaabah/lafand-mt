#!/bin/bash
#SBATCH --job-name=afner        # create a short name for your job
#SBATCH --nodes=1               # node count
#SBATCH --ntasks=1              # total number of tasks across all nodes
#SBATCH --cpus-per-task=2       # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=32G       # total memory per node (4 GB per cpu-core is default)
#SBATCH --gres=gpu:1           # number of gpus per node
####### --partition=mig
#SBATCH --constraint=a100       # for running on an A100 GPU
#SBATCH --time=8:00:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin       # send email when job begins
#SBATCH --mail-type=end         # send email when job ends
#SBATCH --mail-type=fail        # send mail if job fails
#SBATCH --mail-user=hb3815@princeton.edu


export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
# which gpu node was used
echo "Running on host" $(hostname)

# print the slurm environment variables sorted by name
printenv | grep -i slurm | sort

module purge
module load anaconda3/2024.2
#to run experiments in home
#conda activate /home/hb3815/.conda/envs/torch-env
#to run experiments on scratch

# Adroit
conda activate /scratch/network/hb3815/.conda/envs/torch-env

#Della
#conda activate /scratch/gpfs/hb3815/.conda/envs/torch-env

#conda activate torch-env

#gpus=0,1,2,3,4,5,6,7

DATE_WITH_TIME=$(date "+%Y%m%d-%H%M%S")

tokenizer_name=google/mt5-base
model_name=google/mt5-base
data_dir=../datasets/africanlp
max_source_length=256
max_target_length=256
val_max_target_length=150
mode=train

output_dir=../results/africanlp/mt5-base
evaluation_strategy=steps
num_train_epochs=4
per_device_train_batch_size=2
per_device_eval_batch_size=4
gradient_accumulation_steps=128
eval_steps=10000
save_total_limit=10
logging_steps=1000000000000
seed=42
save_steps=100000000000
warmup_steps=10000
learning_rate=1e-4
logging_dir=../results/pqa/all_l3

CUDA_VISIBLE_DEVICES=${gpus} torchrun --nproc_per_node=8 main.py \
  --tokenizer_name ${tokenizer_name} \
  --model_name ${model_name} \
  --data_dir ${data_dir} \
  --max_source_length ${max_source_length} \
  --max_target_length ${max_target_length} \
  --val_max_target_length ${val_max_target_length} \
  --mode ${mode} \
  --task_type generation_id \
  --test_type dev \
  --output_dir ${output_dir} \
  --evaluation_strategy ${evaluation_strategy} \
  --num_train_epochs ${num_train_epochs} \
  --per_device_train_batch_size ${per_device_train_batch_size} \
  --per_device_eval_batch_size ${per_device_eval_batch_size} \
  --gradient_accumulation_steps ${gradient_accumulation_steps}\
  --eval_steps ${eval_steps} \
  --save_total_limit ${save_total_limit} \
  --logging_steps ${logging_steps} \
  --seed ${seed} \
  --save_steps ${save_steps} \
  --warmup_steps ${warmup_steps} \
  --learning_rate ${learning_rate} \
  --logging_dir ${logging_dir} \
  --overwrite_output_dir \
  --load_best_model_at_end \
  --num_labels 3 \
  --sharded_ddp zero_dp_3
#  --fp16
