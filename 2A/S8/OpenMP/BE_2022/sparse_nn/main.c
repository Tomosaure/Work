#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <string.h>
#include <math.h>
#include "omp.h"
#include "aux.h"

void sequential_nn(layer *layers, int n, int L);
void parallel_nn_loops(layer *layers, int n, int L);
void parallel_nn_tasks(layer *layers, int n, int L);

int main(int argc, char **argv)
{
  int n, m, N, L, i;
  long t_start, t_end;
  layer *layers_se, *layers_pl, *layers_pt;

  // Command line arguments
  if (argc == 3)
  {
    n = atoi(argv[1]); /* size of layers */
    L = atoi(argv[2]); /* number of layers in the network */
  }
  else
  {
    printf("Usage:\n\n ./main n L\n\nsuch that n is the size of the layers and L is the number of layers.\n");
    return 1;
  }

  layers_se = (layer *)malloc(sizeof(layer) * L);
  layers_pl = (layer *)malloc(sizeof(layer) * L);
  layers_pt = (layer *)malloc(sizeof(layer) * L);

  init(layers_se, n, L);
  copy_nn(layers_se, layers_pl, n, L);
  copy_nn(layers_se, layers_pt, n, L);

  t_start = usecs();
  sequential_nn(layers_se, n, L);
  t_end = usecs();
  printf("Sequential     time    : %8.2f msec.\n", ((double)t_end - t_start) / 1000.0);

  t_start = usecs();
  parallel_nn_loops(layers_pl, n, L);
  t_end = usecs();
  printf("Parallel loops time    : %8.2f msec.    ", ((double)t_end - t_start) / 1000.0);

  check_result(layers_se, layers_pl, n, L);

  t_start = usecs();
  parallel_nn_tasks(layers_pt, n, L);
  t_end = usecs();
  printf("Parallel tasks time    : %8.2f msec.    ", ((double)t_end - t_start) / 1000.0);

  check_result(layers_se, layers_pt, n, L);

  return 0;
}

void sequential_nn(layer *layers, int n, int L)
{
  int i, j, l, s;

  for (l = 0; l < L - 1; l++)
  {
    // printf("layer %2d  m:%2d\n", l, layers[l].m);
    for (s = 0; s < layers[l].m; s++)
    {
      i = layers[l].syn[s].i;
      j = layers[l].syn[s].j;
      // printf("layer %2d  i:%2d  j:%2d, bidule: %f\n", l, i, j, update(layers[l].neu[i].nv, layers[l].syn[s].sv));
      layers[l + 1].neu[j].nv += update(layers[l].neu[i].nv, layers[l].syn[s].sv);
    }
  }
}

void parallel_nn_loops(layer *layers, int n, int L)
{
  int i, j, l, s;

#pragma omp parallel private(i, j, l, s)

  for (l = 0; l < L - 1; l++)
  {
// printf("layer %2d  m:%2d\n", l, layers[l].m);
#pragma omp for
    for (s = 0; s < layers[l].m; s++)
    {
      i = layers[l].syn[s].i;
      j = layers[l].syn[s].j;
      // printf("layer %2d  i:%2d  j:%2d\n", l, i, j);
      layers[l + 1].neu[j].nv += update(layers[l].neu[i].nv, layers[l].syn[s].sv);
    }
  }
}

void parallel_nn_tasks(layer *layers, int n, int L)
{
  int i, j, l, s;

#pragma omp parallel private(i, j, l, s)

#pragma omp single

  for (l = 0; l < L - 1; l++)
  {
    // printf("layer %2d  m:%2d\n", l, layers[l].m);
    for (s = 0; s < layers[l].m; s++)
    {
      i = layers[l].syn[s].i;
      j = layers[l].syn[s].j;
#pragma omp task firstprivate(i, j, l, s) depend(in:layers[l].neu[i].nv) depend(out:layers[l + 1].neu[j].nv)
      {
        layers[l + 1].neu[j].nv += update(layers[l].neu[i].nv, layers[l].syn[s].sv);
      }
    }
  }
}

/*

Résultats: n=10, L=10, host=tanche.enseeiht.fr

threads = 1:
Sequential     time    :   674.12 msec.
Parallel loops time    :   674.15 msec.    Result is correct :-)
Parallel tasks time    :   674.24 msec.    Result is correct :-)

threads = 2:
Sequential     time    :   674.10 msec.
Parallel loops time    :   386.93 msec.    Result is correct :-)
Parallel tasks time    :   339.44 msec.    Result is correct :-)

threads = 4:
Sequential     time    :   674.11 msec.
Parallel loops time    :   213.75 msec.    Result is correct :-)
Parallel tasks time    :   177.86 msec.    Result is correct :-)

threads = 10:
Sequential     time    :   674.10 msec.
Parallel loops time    :   115.60 msec.    Result is correct :-)
Parallel tasks time    :   120.10 msec.    Result is correct :-)

threads = 20:
Sequential     time    :   674.16 msec.
Parallel loops time    :    82.55 msec.    Result is correct :-)
Parallel tasks time    :   108.47 msec.    Result is correct :-)

threads = 30:
Sequential     time    :   674.08 msec.
Parallel loops time    :    85.55 msec.    Result is correct :-)
Parallel tasks time    :   108.53 msec.    Result is correct :-)


Commentaires:
On observe un accélération notable de notre puissance de calcul.
Notre temps de calcul est environ divisé par le nombre de threads.
On observe tout de même un rendement décroissant s'il l'on augmente trop le nombre de threads,
et si la taille de nos données est limité, si on augmentre notre charge de calcul alors on retrouve notre avantage :

threads = 30, n=50, L=5:
Sequential     time    :  7808.44 msec.
Parallel loops time    :   346.61 msec.    Result is correct :-)
Parallel tasks time    :   296.00 msec.    Result is correct :-)

*/