#include <aux.h>






int main() {
    int i, sum, n=1000;
    int x[n];  

    rand_fill(x, n); sum=0;

#pragma omp parallel for
    for(i=0; i<n; i++){
       sum += sum + 1;
    }

    printf("Sum is %d\n",sum);

return 0;
}
