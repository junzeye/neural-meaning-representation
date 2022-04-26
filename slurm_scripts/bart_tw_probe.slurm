#!/bin/bash
#SBATCH --job-name=bart_tw_probe # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:1             # number of gpus per node
#SBATCH --mem-per-cpu=8G         # memory per cpu-core (4G is default)

#SBATCH --constraint=v100

#SBATCH --time=09:00:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send email if job fails
#SBATCH --mail-user=akaz@princeton.edu


module purge
module load anaconda3/2021.11
conda activate /scratch/network/akaz/conda/nlp_final
export PYTHONPATH=.
export TOKENIZERS_PARALLELISM=true

python scripts/probe_textworld.py \
    --arch bart --data tw_data/simple_traces --gamefile tw_data/simple_games \
    --probe_target final.full_belief_facts_pair --encode_tgt_state NL.bart \
    --localizer_type belief_facts_pair_all --probe_type 3linear_classify \
    --probe_agg_method avg --tgt_agg_method avg \
    --lm_save_path 'twModels/pre_bart_lr1e-05_simple_traces_seed42.p' \
    --ents_to_states_file 'tw_data/simple_traces/entities_to_facts/belief_facts_pair_bart_state_model_pre_bart_lr1e-05_simple_traces_seed42.p' \
    --eval_batchsize 256 --batchsize 32
