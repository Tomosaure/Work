#include "aux.h"
#include "omp.h"

int main(int argc, char **argv)
{
  long t_start;
  double time;
  int i, j, n;
  Stack stacks[ntypes];
  Request req;
  int head;

  init(stacks);

  t_start = usecs();

#pragma omp parallel shared(stacks)
  {
#pragma omp single
    {
      for (;;)
      {

        req = receive();

        // printf("Received request %d\n",req.id);
        if (req.type != -1)
        {

#pragma omp task firstprivate(req)
          {
            // printf("Thread %d, processing request %d\n", omp_get_thread_num(), req.id);
            Result result = process(&req);
            // on fait un atomic update car l'on a que un seul stacks pour tous les threads (normalement ?)
#pragma omp atomic update
            stacks[req.type].head += 1;
            stacks[req.type].results[stacks[req.type].head] = result;
          }
        }
        else
        {
          break;
        }
      }
    }
  }

  time = (double)(usecs() - t_start) / 1000000.0;
  printf("Finished. Execution time:%.2f \n", time);

  check(stacks);

  return 0;
}

/*

Résultats:

nb_threads = 1  : Execution time: 1.19
nb_threads = 2  : Execution time: 0.63
nb_threads = 4  : Execution time: 0.34
nb_threads = 6  : Execution time: 0.22
nb_threads = 8  : Execution time: 0.17
nb_threads = 10 : Execution time: 0.15

*/