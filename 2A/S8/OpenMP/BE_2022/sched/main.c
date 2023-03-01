#include "aux.h"
#include "omp.h"
#define MAX_THREADS 30

void loop1(int n)
{
  long t_start, t_end;
  double time_it;
  double times[MAX_THREADS];
  int i, nb_threads;

  double load = 0.0;

#pragma omp parallel

#pragma omp for schedule(static)
  for (i = 0; i < n; i++)
  {
    t_start = usecs();
    func1(i, n);
    time_it = (double)(usecs() - t_start);
    load += time_it;
    times[omp_get_thread_num()] += time_it;
    if (n <= 20)
    {
      printf("Iteration %6d of loop 1 took %.2f usecs (executed by thread: %2d, load: %f)\n", i, time_it, omp_get_thread_num(), times[omp_get_thread_num()]);
    }
  }

#pragma omp master
  {
    double min = *times;
    double max = *times;

    for (int j = 0; j < MAX_THREADS; j++)
    {
      if (times[j] > max)
      {
        max = times[j];
      }
      if (times[j] < min && times[j] >= 0.001)
      {
        min = times[j];
      }
    }

    printf("rapport: %f, min: %f, max: %f\n\n", max / min, min, max);
  }
}

void loop2(int n)
{
  long t_start, t_end;
  double time_it, load;
  double times[MAX_THREADS];
  int i;

  load = 0.0;

#pragma omp parallel

#pragma omp for schedule(dynamic)
  for (i = 0; i < n; i++)
  {
    t_start = usecs();
    func2(i, n);
    time_it = (double)(usecs() - t_start);
    load += time_it;
    times[omp_get_thread_num()] += time_it;
    if (n <= 20)
    {
      printf("Iteration %6d of loop 2 took %.2f usecs (executed by thread: %2d, load: %f)\n", i, time_it, omp_get_thread_num(), times[omp_get_thread_num()]);
    }
  }

#pragma omp master
  {
    double min = *times;
    double max = *times;

    for (int j = 0; j < MAX_THREADS; j++)
    {
      if (times[j] > max)
      {
        max = times[j];
      }
      if (times[j] < min && times[j] >= 0.001)
      {
        min = times[j];
      }
    }

    printf("rapport: %f, min: %f, max: %f\n\n", max / min, min, max);
  }
}

void loop3(int n)
{
  long t_start, t_end;
  double time_it, load;
  double times[MAX_THREADS];
  int i;

  load = 0.0;

#pragma omp parallel

#pragma omp for schedule(guided)
  for (i = 0; i < n; i++)
  {
    t_start = usecs();
    func3(i, n);
    time_it = (double)(usecs() - t_start);
    load += time_it;
    times[omp_get_thread_num()] += time_it;
    if (n <= 20)
      printf("Iteration %6d of loop 3 took %.2f usecs (executed by thread: %2d, load: %f)\n", i, time_it, omp_get_thread_num(), times[omp_get_thread_num()]);
  }

#pragma omp master
  {
    double min = *times;
    double max = *times;

    for (int j = 0; j < MAX_THREADS; j++)
    {
      if (times[j] > max)
      {
        max = times[j];
      }
      if (times[j] < min && times[j] >= 0.001)
      {
        min = times[j];
      }
    }

    printf("rapport: %f, min: %f, max: %f\n\n", max / min, min, max);
  }
}

int main(int argc, char **argv)
{
  int i, j, n;

  // Command line argument
  if (argc == 2)
  {
    n = atoi(argv[1]); /* the number of loop iterations */
  }
  else
  {
    printf("Usage:\n\n ./main n \n\nwhere n is the number of iterations in the loops\n");
    return 1;
  }

  printf("\n");

  loop1(n);

  printf("\n");

  loop2(n);

  printf("\n");

  loop3(n);

  printf("\n");

  return 0;
}

/*

Commentaires:

loop1 : les time_it sont pratiquement tous les mêmes, on sélectionne le scheduling static
loop2 : les time_it sont pratiquement tous très différents, on sélectionne le scheduling dynamic
loop3 : les time_it sont "croissants", on sélectionne le scheduling guided, pour être static au début puis dynamic à la fin


pour de grandes valeurs de n, on observer que le rapport tend vers 1 pour chacun des loops.

*/