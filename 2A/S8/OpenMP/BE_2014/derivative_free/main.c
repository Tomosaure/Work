#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "aux.h"
#include "omp.h"
#define MAX_THREADS 16
#define MAXIT 1000000

double sequential_minimization(double s, int p, double x0, double y0);
double parallel_minimization(double s, int p, double x0, double y0);

int main(int argc, char **argv)
{
  long t_start, t_end;
  double s, x0, y0, z;
  int i, p;

  // Command line argument: array length
  if (argc == 3)
  {
    p = atoi(argv[1]); /* the number of points to be evaluated */
    s = atof(argv[2]); /* the step length */
  }
  else
  {
    printf("Usage:\n\n ./main p s\n\nwhere p is the number of points around the current minimum where the function has to be evaluated\nand s is the step size.\n");
    return 1;
  }

  /* No need to change this seetings unless for debugging */
  x0 = 10;
  y0 = 10;

  t_start = usecs();
  z = sequential_minimization(s, p, x0, y0);
  t_end = usecs();
  printf("Sequential   time    : %8.2f msec.\n", ((double)t_end - t_start) / 1000.0);

  printf("\n\n");

  t_start = usecs();
  z = parallel_minimization(s, p, x0, y0);
  t_end = usecs();
  printf("Parallel     time    : %8.2f msec.\n", ((double)t_end - t_start) / 1000.0);

  return 0;
}

double parallel_minimization(double s, int p, double x0, double y0)
{
  int i;
  int cnt = 0;
  double x, y, z;
  double nx, ny, nz;
  double min_nx, min_ny, min_nz;
  double xyz[MAX_THREADS][3];
  int running = 1;

  min_nx = x0;
  min_ny = y0;
  min_nz = evaluate(min_nx, min_ny);

#pragma omp parallel shared(cnt, xyz, running)

  xyz[omp_get_thread_num()][0] = x0;
  xyz[omp_get_thread_num()][1] = y0;
  xyz[omp_get_thread_num()][2] = evaluate(xyz[omp_get_thread_num()][0], xyz[omp_get_thread_num()][1]);

  while (cnt < MAXIT && running)
  {
    x = xyz[omp_get_thread_num()][0];
    y = xyz[omp_get_thread_num()][1];
    z = xyz[omp_get_thread_num()][2];
    /* Evaluate function on the 8 points around the current minimum */
    /* The current minimum is included again in the evaluation for
       simplicipy; this makes a total of 9 evaluations */
#pragma omp for
    for (i = 0; i < p; i++)
    {
      nx = x + s * cos(2.0 * M_PI * i / ((double)p));
      ny = y + s * sin(2.0 * M_PI * i / ((double)p));
      nz = evaluate(nx, ny);
      /* printf("%f %f %f\n",nx,ny,nz); */
      /* If the evaluation at this point is lower than the current
         minimum, set this point as the new minimum */
      if (nz < xyz[omp_get_thread_num()][2])
      {
        xyz[omp_get_thread_num()][0] = nx;
        xyz[omp_get_thread_num()][1] = ny;
        xyz[omp_get_thread_num()][2] = nz;
      }
    }
    /* Uncomment the line below if you want to debug */
    /* printf("%4d -- %5.2f %5.2f %10.4f\n",cnt,xyz[0][0], xyz[0][1], xyz[0][2]); */

#pragma omp master
    {
      // increment counter
      cnt++;

      // get result from threads
      for (i = 0; i < MAX_THREADS; i++)
      {
        if (min_nz > xyz[i][2])
        {
          min_nx = xyz[i][0];
          min_ny = xyz[i][1];
          min_nz = xyz[i][2];
        }
      }

      /* If no improvement over the old minimum, terminate */
      if (xyz[omp_get_thread_num()][2] >= z)
      {
        running = 0;
      }
    }
  }

  printf("Minimum found is %.10f  at x=%.4f, y=%.4f  in %d steps\n", min_nx, min_nz, min_ny, cnt);
  return min_nz;
}

double sequential_minimization(double s, int p, double x0, double y0)
{

  int cnt, i;
  double z, x, y, nx, ny, nz;
  double xyz[MAX_THREADS][3];

  xyz[0][0] = x0;
  xyz[0][1] = y0;
  xyz[0][2] = evaluate(xyz[0][0], xyz[0][1]);

  for (cnt = 0; cnt < MAXIT; cnt++)
  {
    x = xyz[0][0];
    y = xyz[0][1];
    z = xyz[0][2];
    /* Evaluate function on the 8 points around the current minimum */
    /* The current minimum is included again in the evaluation for
       simplicipy; this makes a total of 9 evaluations */
    for (i = 0; i < p; i++)
    {
      nx = x + s * cos(2.0 * M_PI * i / ((double)p));
      ny = y + s * sin(2.0 * M_PI * i / ((double)p));
      nz = evaluate(nx, ny);
      /* printf("%f %f %f\n",nx,ny,nz); */
      /* If the evaluation at this point is lower than the current
         minimum, set this point as the new minimum */
      if (nz < xyz[0][2])
      {
        xyz[0][2] = nz;
        xyz[0][0] = nx;
        xyz[0][1] = ny;
      }
    }
    /* Uncomment the line below if you want to debug */
    /* printf("%4d -- %5.2f %5.2f %10.4f\n",cnt,xyz[0][0], xyz[0][1], xyz[0][2]); */

    /* If no improvement over the old minimum, terminate */
    if (xyz[0][2] >= z)
      break;
  }

  printf("Minimum found is %.10f  at x=%.4f, y=%.4f  in %d steps\n", xyz[0][2], xyz[0][0], xyz[0][1], cnt);
  return xyz[0][2];
}
