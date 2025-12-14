#include <cuda_runtime.h>
#include <stdio.h>

int main(void) {
  int deviceCount = 0;
  cudaError_t err = cudaGetDeviceCount(&deviceCount);

  if (err != cudaSuccess) {
    printf("Error al conseguir el numero de GPUs");
  } else {
    printf("En total hay %d GPUs disponibles", deviceCount);
  }
  return 0;
}
