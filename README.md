# TP23-Coursework2-B144511

An OpenMP parallel implementation for two C versions of codes, which implement the same adaptive quadrature algorithms in two different ways

# B144511TP-Coursework1-Code

Threaded Programming Coursework

> # Threaded Programming Coursework Part 2
> #### **Author: Exam Number B144511**
--------------------------------------------------------------------------
>> This is an **OpenMP** implementation of the two versions of the *divide-and-conquer* algorithm. 
When run on multiple threads, 
>> ## *solver1* 
>>> the master thread initiates simulation variables, and create a parallel region. A single thread calls a routine which creates two tasks.  These tasks can create further tasks through recursive calls.
>> ## *solver2*
>>> the master thread initiates simulation variables, and creates a parallel region.  All threads will attempt to process the intervals in the queue.  Access to the queue is syncronised using critical regions.
>> ## *solver3*
>>> execute just like solver1, exept, the task creation can be limited using a command line argument....
> ## Source and Header Files: (located in the same folder)
--------------------------------------------------------------------------
>> **Source file and Functionality**
>> - **function.c:** The the code for evaluating the simpson function.  
>> - **function.h:** Header for the function that links to all other libraries required for the program.
>> - **solver1.c:**  Parallel implementation of solver1 (recursive function calls and OpenMP tasks). 
>> - **solver2.c:**  Parallel implementation of solver2 (queue, OpenMP Parallel region and syncronisation using Critical regions).  
>> - **solver3.c:**  *solver1.c* version that limits with an if clause on the tasks to limit the reculsion depth at which tasks are created.  
>> ## The following are source files required for the solver1.c, solver2.c and solver3.c:
>> - **solver.h:**   Header that contains links to all other libraries for the program
>> - **queuelib.c:** User defined functions for the queue - initialise queue, checking whether the queue is empty, the number of entries in the queue, add an interval to the queue, extract last interval from queue, get first of second half of the interval.
>> - **solverlib.c:**  User defined functions for the implementation of the algorithm: simpson's function evaluation step.

> ## Building the code on Cirrus. 
--------------------------------------------------------------------------
>> - On Cirrus, build and run both parallel versions using either the *Intel 20.4 compiler* with the *-O3 -qopenmp* flags; or the *GNU 10.2 compiler* with the *-O3 -fopenmp* fags. Ensure that the compiler is loaded before compiling the code. i.e.
>>> module load intel-20.4/compilers
>> - Compile by typing *make*, making sure to specify the compiler flags in the Make file accordingly prior to compilation.
> ## Running the code using job submission.
--------------------------------------------------------------------------
>> Batch processing is the only way of running the program on Cirrus compute nodes. This implementation is supplied with a shell script *solver.slurm*. Please submit a job as follows:
>>> sbatch solver.slurm

>> Change the OpenMP environmental variables in the solver.slum script accordingly in order to achieve the desired OpenMP parallelism.  For example, to change the number of threads, edit the script and change the value assigned to the *OMP_NUM_THREADS* variable.  

>>Run the desired executable (i.e. *solver#* where # is 1 and 2) without arguments. For example, to run the *solver2* on Cirrus login node on 16 threads, use the following commands:
>>> export OMP_NUM_THREADS=16
>>> srun --cpu-bind=cores ./solver2

>> The code produces a text output file called “slurm_######.out”
Result = 6.019096e-03
Time(s) = 14.133170

>>Run the *solver3* with an optional argument. The argument is a maximum depth (threashold) at which tasks are created. 
>>> The default THREASHOLD = 21.  This is adjustable as follows:
>>>> srun --cpu-bind=cores ./solver3 [THREASHOLD]
