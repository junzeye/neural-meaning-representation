#!/bin/bash
#SBATCH --job-name=mt5_nopretrain_alchemy_metrics # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:1             # number of gpus per node
#SBATCH --mem-per-cpu=12G         # memory per cpu-core (4G is default)

#SBATCH --time=03:59:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send email if job fails
#SBATCH --mail-user=bychan@princeton.edu


module purge
source /scratch/network/bychan/pull/nlp-final-project/venv/bin/activate
export PYTHONPATH=/scratch/network/bychan/pull/nlp-final-project
export TOKENIZERS_PARALLELISM=true
python scripts/probe_alchemy.py \
    --arch mt5 --lm_save_path sconeModels/alchemy_random_init_model_mt5 \
    --eval_only --probe_save_path probe_models_alchemy/encoded_NL.mt5linear_single_beaker_init_full_avgavg_alchemy_random_init_model_mt5_l-1_single_beaker_final.NL_real.pState \
    --no_pretrain  \
    --encode_init_state NL --nonsynthetic \
    --probe_target single_beaker_final.NL --localizer_type single_beaker_init_full \
    --probe_type linear --probe_agg_method avg \
    --encode_tgt_state NL.mt5 --tgt_agg_method avg \
    --batchsize 128 --eval_batchsize 1024 --lr 1e-4