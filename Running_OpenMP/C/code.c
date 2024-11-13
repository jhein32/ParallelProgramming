#include <stdio.h>
#include <omp.h>

int main()
{

  const int finval = 100000000;

  double pi_square = 0.0;

  // thread management variables
  int thread_id, thread_num;

  // accumulation variable
  double local_pi;

  // local work management
  int my_num, my_first, my_last;

#ifdef _OPENMP
  double start_time = omp_get_wtime();
#endif
    
#pragma omp parallel default(none) shared(pi_square) \
  private(thread_id, thread_num, local_pi, my_num, my_first, my_last)
  {
    thread_id  = omp_get_thread_num();
    thread_num = omp_get_num_threads();

    if (thread_id == 0)
    printf("Using %i threads.\n", thread_num);

#pragma omp barrier
    my_num   = finval/thread_num;
    my_first = 1 + thread_id * my_num;
    my_last  = (thread_id + 1) * my_num;

    local_pi = 0.0;
    
    for ( int i=my_first ; i <= my_last; i++)
      {  
	double factor = (double) i;
	local_pi += 1.0/( factor * factor );
      }

#pragma omp atomic update
    pi_square += local_pi;
  }

#ifdef _OPENMP
  double end_time = omp_get_wtime() - start_time;
#endif

  printf ( "Pi^2 = %.10f\n", pi_square*6.0);
  
#ifdef _OPENMP
  printf ( "Time taken: %f s\n", end_time);
#endif

  return 0;
}
