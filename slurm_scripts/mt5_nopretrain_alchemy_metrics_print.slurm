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
python3 scripts/print_metrics.py \
    --arch mt5 --domain alchemy \
    --pred_files \
    /scratch/network/bychan/pull/nlp-final-project/probe_models_alchemy