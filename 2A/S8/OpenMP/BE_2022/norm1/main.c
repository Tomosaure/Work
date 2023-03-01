#include "aux.h"
#include "omp.h"

double norm1(double **A, int m, int n);
double norm1_colmajor(double **A, int m, int n);
double norm1_rowmajor(double **A, int m, int n);

int main(int argc, char **argv)
{
  long t_start, t_end;
  int m, n, i, j;
  double nrm, nrmrm, nrmcm;
  double **A;

  // Command line argument: matrix size
  if (argc == 3)
  {
    m = atoi(argv[1]); /* the number of matrix rows */
    n = atoi(argv[2]); /* the number of matrix cols */
  }
  else
  {
    printf("Usage:\n\n ./main n m\n\nwhere m and n are the number of rows and cols in the matrix\n");
    return 1;
  }

  A = (double **)malloc(m * sizeof(double *));
  for (i = 0; i < m; i++)
  {
    A[i] = (double *)malloc(n * sizeof(double));

    for (j = 0; j < n; j++)
    {
      A[i][j] = ((double)rand() / (double)RAND_MAX);
    }
  }

  /* warm up */
  nrm = norm1(A, m, n);

  t_start = usecs();
  nrm = norm1(A, m, n);
  t_end = usecs() - t_start;
  printf("Sequential  --  norm:%8.4f   time (usecs):%6ld\n", nrm, t_end);

  t_start = usecs();
  nrmcm = norm1_colmajor(A, m, n);
  t_end = usecs() - t_start;
  printf("Col-major   --  norm:%8.4f   time (usecs):%6ld\n", nrmcm, t_end);

  t_start = usecs();
  nrmrm = norm1_rowmajor(A, m, n);
  t_end = usecs() - t_start;
  printf("Row-major   --  norm:%8.4f   time (usecs):%6ld\n", nrmrm, t_end);

  printf("\n");

  return 0;
}

double norm1(double **A, int m, int n)
{
  int i, j;
  double nrm, tmp;
  nrm = 0.0;

  for (j = 0; j < n; j++)
  {
    tmp = 0.0;
    for (i = 0; i < m; i++)
    {
      tmp += fabs(A[i][j]);
    }
    if (tmp > nrm)
      nrm = tmp;
  }

  return nrm;
}

double norm1_colmajor(double **A, int m, int n)
{
  int i, j;
  double nrm = 0.0;
  double tmp;

#pragma omp parallel private(i, j, tmp) shared(nrm)

#pragma omp for
  for (j = 0; j < n; j++)
  {
    tmp = 0.0;
    for (i = 0; i < m; i++)
    {
      tmp += fabs(A[i][j]);
    }

    if (tmp > nrm)
    {
#pragma omp atomic write
      nrm = tmp;
    }
  }

  return nrm;
}

double norm1_rowmajor(double **A, int m, int n)
{
  int i, j;
  double nrm, *tmp;

  nrm = 0.0;
  tmp = (double *)malloc(n * sizeof(double));
  for (j = 0; j < n; j++)
  {
    tmp[j] = 0.0;
  }

#pragma omp parallel private(i, j) shared(tmp)

#pragma omp for
  for (i = 0; i < m; i++)
  {
    for (j = 0; j < n; j++)
    {
#pragma omp atomic update
      tmp[j] += fabs(A[i][j]);
    }
  }

#pragma omp single
  {
    for (int k = 0; k < n; k++)
    {
      if (tmp[k] > nrm)
      {
        nrm = tmp[k];
      }
    }

    free(tmp);
  }

  return nrm;
}

/*

Résultats: n=100000 m=1000

threads = 1:
Sequential  --  norm:50277.9944   time (usecs):770322
Col-major   --  norm:50277.9944   time (usecs):766831
Row-major   --  norm:50277.9944   time (usecs):775600

threads = 2:
Sequential  --  norm:50277.9944   time (usecs):745682
Col-major   --  norm:50277.9944   time (usecs):394515
Row-major   --  norm:50277.9944   time (usecs):954254

threads = 4:
Sequential  --  norm:50277.9944   time (usecs):747250
Col-major   --  norm:50277.9944   time (usecs):296826
Row-major   --  norm:50277.9944   time (usecs):559891

threads = 30:
Sequential  --  norm:50277.9944   time (usecs):748683
Col-major   --  norm:50277.9944   time (usecs):253433
Row-major   --  norm:50277.9944   time (usecs):436225


On observe que col-major est la plus rapide.
Cela est surement dû au atomic update nécéssaire dans la boucle for.
Une version meilleur serait de créer une liste tmp par thread, et de ensuite les sommer à la fin,
mais une ébauche non finis est disponible dans le fichier main.c.broken.

*/