#!/bin/bash
#SBATCH --job-name=mt5_nopretrain_tw_probe.slurm # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:1             # number of gpus per node
#SBATCH --mem-per-cpu=16G         # memory per cpu-core (4G is default)

#SBATCH --time=03:59:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send email if job fails
#SBATCH --mail-user=bychan@princeton.edu


module purge
source /scratch/network/bychan/pull/nlp-final-project/venv/bin/activate
export PYTHONPATH=/scratch/network/bychan/pull/nlp-final-project
export TOKENIZERS_PARALLELISM=true
python scripts/probe_textworld.py \
    --arch mt5 --data tw_data/simple_traces --gamefile tw_data/simple_games \
    --probe_target final.full_belief_facts_pair --encode_tgt_state NL.mt5 \
    --local_files_only \
    --localizer_type belief_facts_pair_all --probe_type 3linear_classify \
    --probe_agg_method avg --tgt_agg_method avg \
    --lm_save_path twModels/textworld_random_init_model_mt5 --no_pretrain \
    --ents_to_states_file sconeModels/textworld_random_init_model_mt5 \
    --eval_batchsize 256 --batchsize 32