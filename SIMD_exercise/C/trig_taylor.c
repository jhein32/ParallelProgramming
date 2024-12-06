#include "trig_taylor.h"

double sin_taylor(double x)
{
  const int order = 6; 

  double coefs[] = { 1.0, -1.6666666666666666666666666e-1,		\
		     8.3333333333333333333333333e-3, -1.9841269841269841e-4, \
		     2.7557319223985891e-6, -2.5052108385441719e-8};
  
  double xpow = x;
  double val  = x;
  for (int i = 1; i < order; i++)
    {
      xpow = xpow * x * x;
      val += coefs[i] * xpow;
    }

  return val;
}
