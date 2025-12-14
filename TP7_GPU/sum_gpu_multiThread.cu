// sum_gpu_multiThread.cu
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
// Cantidad de elementos en el array. Disminuir si no alcanza la memoria.
#define ARR_SIZE 100000000
// Cantidad de hilos
#define THREAD_COUNT 256
// Suma una posición de nums1 y nums2, en nums3
// Atributo "__global__" indica que función correrá en la GPU. ¡Debe devolver
// void! blockDim, blockIdx, y threadIdx son definidas por la GPU y accesibles
// desde cualquier código que corra en la GPU, indican la posición del hilo
// actual en la grilla Utilizamos solo la componente x puesto que decidimos
// trabajar con una grilla de una dimensión.
__global__ void sum_arrays(int *nums1, int *nums2, int *nums3, int dimension) {
  int tid = (blockDim.x * blockIdx.x) + threadIdx.x;
  // Como redondeé para arriba el número de hilos, me aseguro que no sea uno de
  // los que sobra
  if (tid < dimension)
    nums3[tid] = nums1[tid] + nums2[tid];
}
// Evalúa posibles errores
int check_error(int *nums1, int *nums2, int *nums3, int dimension) {
  for (int i = 0; i < dimension; i++)
    if (nums1[i] + nums2[i] != nums3[i])
      return -1;
  return 0;
}
int main() {
  // Genera dos arrays de enteros y lo rellena con numeros al azar
  int *nums1, *nums2, *nums3;
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
  // Si cada bloque tendrá THREAD_COUNT hilos, ¿cuántos bloques necesitamos para
  // tener un hilo por elemento del vector?
  int NUM_BLOCKS = (int)ceil(ARR_SIZE / THREAD_COUNT);
  // Corremos la función en NUM_BLOCKS bloques de THREAD_COUNT hilos cada uno
  sum_arrays<<<NUM_BLOCKS, THREAD_COUNT>>>(nums1, nums2, nums3, ARR_SIZE);
  // Llamada a la GPU es asíncrona, es decir, retorna inmediatamente, sin que la
  // llamada a la función haya realmente concluído Por este motivo, debemos
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
