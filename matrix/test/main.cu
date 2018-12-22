#include <iostream>
#include "../src/cuda-indexing.h"
#include <Matrix.h>

__global__
void multiply_matrix(int n, float *a, float *b, float *c)
{
    int index = blockIdx.x * blockDim.x + threadIdx.x;

    int line = index / n;
    int column = index % n;

    for(int k = 0; k < n; k++)
        c[line * n + column] += a[line * n + k] * b[k * n + column];

    return ;
}

int main()
{
    int n = 10000;
    float *a, *b, *c;
    cudaMallocManaged(&a, n * n * sizeof(float));
    cudaMallocManaged(&b, n * n * sizeof(float));
    cudaMallocManaged(&c, n * n * sizeof(float));

    for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
        {
            a[i * n + j] = (i + j) * 0.01f;
            b[i * n + j] = (i * i + j * j + 0.2f) * 0.001f;
        }
    }

    multiply_matrix<<<(n + 128 - 1) / 128, 128>>>(n, a, b, c);
    cudaDeviceSynchronize();

    /*for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
            std::cout << b[i * n + j] << " ";
        std::cout << "\n";
    }*/

    cudaFree(a);
    cudaFree(b);
    cudaFree(c);
    return 0;
}