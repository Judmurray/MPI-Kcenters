#!/bin/bash
#SBATCH -A cmda3634_rjh
#SBATCH -p normal_q
#SBATCH -t 00:10:00
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=64
#SBATCH -o mpi_kcenter_search.out

# Go to the directory where the job was submitted
cd $SLURM_SUBMIT_DIR

# Load the modules we need for MPI
module load matplotlib

# Build the executable
mpicc -O3 -o mpi_kcenter mpi_kcenter.c

# run mpi_work on nodes*ntasks-per-node cores
mpiexec -np $SLURM_NTASKS --map-by ppr:$SLURM_NTASKS_PER_NODE:node ./mpi_kcenter $1 $2 $3 $4

# The script will exit whether we give the "exit" command or not.
exit
