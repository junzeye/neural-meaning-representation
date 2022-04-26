#!/bin/bash
#SBATCH --job-name=bart_nopre_get_tw_facts # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:1             # number of gpus per node
#SBATCH --mem-per-cpu=16G         # memory per cpu-core (4G is default)

#SBATCH --time=01:00:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send email if job fails
#SBATCH --mail-user=akaz@princeton.edu


module purge
module load anaconda3/2021.11
conda activate /scratch/network/akaz/conda/nlp_final
export PYTHONPATH=.
export TOKENIZERS_PARALLELISM=true

python scripts/get_all_tw_facts.py \
    --data tw_data/simple_traces --gamefile tw_data/simple_games \
    --state_model_arch bart \
    --probe_target belief_facts_pair \
    --state_model_path 'twModels/nonpre_bart_lr1e-05_simple_traces_seed42.p' \
