// sum_gpu_singleThread.cu
#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
// Cantidad de elementos en el array. Disminuir si no alcanza la memoria
#define ARR_SIZE 100000000
// Suma dos arrays, nums1 y nums2, componente a componente, en nums3
// Atributo "global" indica que función correrá en la GPU. ¡Debe devolver
void !__global__ void sum_arrays(int *nums1, int *nums2, int *nums3,
                                 int dimension) {
  for (int i = 0; i < dimension; i++)
    nums3[i] = nums1[i] + nums2[i];
}
// Evalúa posibles errores
int check_error(int *nums1, int *nums2, int *nums3, int dimension) {
  for (int i = 0; i < dimension; i++)
    if (nums1[i] + nums2[i] != nums3[i])
      return -1;
  return 0;
}
int main() {
  int *nums1, *nums2, *nums3;
  // Reserva espacio para 3 vectores de enteros con ARR_SIZE elementos
  // Nótese que ya no utilizo malloc, porque malloc reserva memoria RAM de la
  // CPU, no accesible por la GPU cudaMallocManaged permite reservar memoria
  // tanto en la CPU como en la GPU y se encarga de sincronizarlas para ahorrar
  // nos esfuerzo Es posible reservar memoria solo en la GPU, o incluso manejar
  // toda la sincronización manualmente si se desea, utilizando cudaMalloc,
  // cudaMemcpy y cudaFree
  cudaMallocManaged(&nums1, ARR_SIZE * sizeof(int));
  cudaMallocManaged(&nums2, ARR_SIZE * sizeof(int));
  cudaMallocManaged(&nums3, ARR_SIZE * sizeof(int));
  // Rellenamos los arrays con valores arbitrarios
  for (int i = 0; i < ARR_SIZE; i++) {
    nums1[i] = 1;
    nums2[i] = 2;
  }
  // Guardamos la hora actual
  clock_t start = clock();
  // Ejecutamos el cálculo
  // Valores entre picos indican cantidad bloques e hilos a crearse, se
  // discutirá en la próxima sección.En este caso, se usará un solo hilo.
  sum_arrays<<<1, 1>>>(nums1, nums2, nums3, ARR_SIZE);
  // Llamada a la GPU es asíncrona, es decir, retorna inmediatamente, sin que la
  // función haya necesariamente concluido su ejecución Por este motivo, debemos
  // esperar a que la GPU termine de trabajar antes de continuar.
  cudaDeviceSynchronize();
  clock_t end = clock();
  double time_taken = ((double)(end - start)) / (CLOCKS_PER_SEC / 1000);
  printf("Resolver el problema (excluyendo inicializaciones) llevó %f "
         "milisegundos\n",
         time_taken);
  if (check_error(nums1, nums2, nums3, ARR_SIZE) != 0)
    printf("Resultado incorrecto\n");
  else
    printf("Resultado correcto\n");
  // Libero los recursos
  cudaFree(nums1);
  cudaFree(nums2);
  cudaFree(nums3);
}
