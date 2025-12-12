#include <stdio.h>
#include <stdlib.h>

int fibonacci(int n);

int main(){

    int n = 5;
    printf("El fibonacci de %d es %d\n", n, fibonacci(n));
    printf("El fibonacci de 10 es %d\n", fibonacci(10));
    return 0;
}

int fibonacci(int n){
    if(n == 0){
        return 0;
    }else if(n == 1){
        return 1;
    }else{
        return fibonacci(n-1) + fibonacci(n-2);
    }
    // 0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987
}


