#!/bin/bash

# Slurm job options (name, compute nodes, job time)
#SBATCH --job-name=loops
#SBATCH --time=0:10:0
#SBATCH --exclusive
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=36

# Replace [budget code] below with your budget code (e.g. dc116-s1234567)
#SBATCH --account=accountid
# We use the "standard" partition as we are running on CPU nodes
#SBATCH --partition=standard
# We use the "short" QoS as our runtime is less than20 mins 
#SBATCH --qos=short

#module load intel-20.4/compilers
#module unload intel-20.4/compilers
module load gcc/10.2.0

# Change to the submission directory
cd $SLURM_SUBMIT_DIR

# Run multiple experiments in the same batch job.

for threads in 8
do
    echo

    # Repeat experiment 3 times to ensure reasonable run times
    for i in {7..12}
    do
	echo "NUM_THREADS, ${threads}"
	# RUN ${i}
	# Set thread limit, active levels of parallelism and the number of threads
	export OMP_THREAD_LIMIT=36
	export OMP_NUM_THREADS=$threads
    
	# Launch the parallel job
	#echo "Solver${i}"
	srun --cpu-bind=cores ./solver3 ${i}
	echo
    done
done


#Wait for all
wait

echo
echo "All done."
