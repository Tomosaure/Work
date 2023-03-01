#include "_aux.h"
#include "omp.h"


void longest_branch_par(node_t *root, unsigned int *longest_branch_weight, unsigned int *longest_branch_leaf){

  *longest_branch_weight = 0;
  *longest_branch_leaf   = -1;
  root->branch_weight = 0;

  int *updates = (int*) calloc(omp_get_max_threads(),sizeof(int));
  #pragma omp parallel
  {
    #pragma omp single
    {
      longest_branch_par_rec(root, longest_branch_weight, longest_branch_leaf, updates);
    }
  }
  for (int thread = 0; thread < omp_get_max_threads(); thread++) {
    printf("%d ",updates[thread]);
  }
  printf("\n");
  free(updates);
  
  
}
  
void longest_branch_par_rec(node_t *root, unsigned int *longest_branch_weight, unsigned int *longest_branch_leaf, int * updates){

  int i;
  
  process(root);
  root->branch_weight += root->weight;

  if(root->nc>0) {
    for(i=0; i<root->nc; i++){
      #pragma omp task firstprivate(i)
      {
        root->children[i].branch_weight = root->branch_weight;
        updates[omp_get_thread_num()] += 1;
        longest_branch_par_rec(root->children+i, longest_branch_weight, longest_branch_leaf,updates);
      }

    }

  } else {
    if(root->branch_weight > *longest_branch_weight){
      *longest_branch_weight = root->branch_weight;
      *longest_branch_leaf   = root->id;
    }
  }
 
}
