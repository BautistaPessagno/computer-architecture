// sum_cpu.cu
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Cantidad de elementos en el array. Disminuir si no alcanza la memoria
#define ARR_SIZE 100000000

// Suma dos arrays, nums1 y nums2, componente a componente, en nums3

void sum_arrays(int *nums1, int *nums2, int *nums3, int dimension) {
  for (int i = 0; i < dimension; i++)
    nums3[i] = nums1[i] + nums2[i];
}
// Evalúa posibles errores
int check_error(int *nums1, int *nums2, int *nums3, int dimension) {
  for (int i = 0; i < dimension; i++) {
    if (nums1[i] + nums2[i] != nums3[i])
      return -1;
  }
  return 0;
}

int main() {
  // Reservo espacio para 3 vectores de enteros con ARR_SIZE elementos
  int *nums1, *nums2, *nums3;
  nums1 = (int *)malloc(ARR_SIZE * sizeof(int));
  nums2 = (int *)malloc(ARR_SIZE * sizeof(int));
  nums3 = (int *)malloc(ARR_SIZE * sizeof(int));
  // Rellenamos los arrays con valores arbitrarios
  for (int i = 0; i < ARR_SIZE; i++) {
    nums1[i] = 1;
    nums2[i] = 2;
  }
  // Guardamos la hora actual
  clock_t start = clock();
  // Ejecutamos el cálculo
  sum_arrays(nums1, nums2, nums3, ARR_SIZE);
  clock_t end = clock();
  double time_taken = ((double)(end - start)) / (CLOCKS_PER_SEC / 1000);
  printf("Resolver el problema (excluyendo inicializaciones) llevo %f "
         "milisegundos\n",
         time_taken);
  if (check_error(nums1, nums2, nums3, ARR_SIZE) != 0)
    printf("Resultado incorrecto\n");
  else
    printf("Resultado correcto\n");
  // Libero los recursos
  free(nums1);
  free(nums2);
  free(nums3);
}
