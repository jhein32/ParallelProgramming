Program pi

  !$ use omp_lib
  
  implicit none

  integer, parameter :: finval = 100000000
  
  double precision :: pi_square = 0.0d0

  ! thread managemeent variables
  integer thread_id, thread_num

  ! accumulation variable
  double precision local_pi

  ! local work management
  integer my_num, my_first, my_last

  ! timing
  !$ double precision start_time, end_time
  
  
  double precision :: factor
  integer:: i

  !$ start_time = omp_get_wtime()

  !$omp parallel default(none) shared(pi_square) &
  !$omp    private(thread_id, thread_num, local_pi, my_num, my_first, my_last, i, factor)

  thread_id  = omp_get_thread_num()
  thread_num = omp_get_num_threads()

  my_num   = finval/thread_num
  my_first = 1 + thread_id * my_num
  my_last  = (thread_id + 1) * my_num
  
  local_pi = 0.0
  
  do i= my_first, my_last
     factor = i
     local_pi = local_pi + 1.0d0/(factor * factor)
  enddo

  !$omp atomic update
  pi_square = pi_square + local_pi

  !$omp end parallel

  !$ end_time = omp_get_wtime() - start_time
  
  print *, 'Pi**2 =', 6.0d0 * pi_square
  !$ print *, 'Time taken: ', end_time
  
end Program pi
