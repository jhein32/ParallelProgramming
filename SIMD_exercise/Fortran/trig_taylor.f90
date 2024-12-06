Module trig_taylor

  !$ use omp_lib
  Implicit none

contains

  function sin_taylor(x)
    double precision, intent(in) :: x
    double precision :: sin_taylor

    integer, parameter :: order=6
    double precision :: xpow
    double precision, dimension(order) :: coefs = (/1.0d0, -1.6666666666666666666666666D-1, &
         8.3333333333333333333333333D-3, -1.9841269841269841D-4, 2.7557319223985891D-6, &
         -2.5052108385441719D-8/)
    
    integer :: i
    
    xpow = x
    sin_taylor = xpow
    do i = 2, order
       xpow = xpow * x *x
       sin_taylor = sin_taylor + coefs(i) * xpow
    enddo

  end function sin_taylor


End module trig_taylor
