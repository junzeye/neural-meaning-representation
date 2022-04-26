#!/bin/bash
#SBATCH --job-name=bart_alch_nopre_nosyn # create a short name for your job
#SBATCH --nodes=1                # node count
#SBATCH --ntasks=1               # total number of tasks across all nodes
#SBATCH --cpus-per-task=1        # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --gres=gpu:1             # number of gpus per node
#SBATCH --mem-per-cpu=8G         # memory per cpu-core (4G is default)

#SBATCH --constraint=v100

#SBATCH --time=06:00:00          # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin        # send email when job begins
#SBATCH --mail-type=end          # send email when job ends
#SBATCH --mail-type=fail         # send email if job fails
#SBATCH --mail-user=akaz@princeton.edu


module purge
module load anaconda3/2021.11
conda activate /scratch/network/akaz/conda/nlp_final
export PYTHONPATH=.
export TOKENIZERS_PARALLELISM=true
python scripts/train_alchemy.py \
       --arch bart --local_files_only --no_pretrain \
       --encode_init_state NL
