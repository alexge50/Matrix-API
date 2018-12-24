#include <iostream>
#include "../include/cuda-indexing.h"
#include <Matrix.h>

/*
__global__
void multiply_matrix(int n, float *a, float *b, float *c)
{
    int index = blockIdx.x * blockDim.x + threadIdx.x;

    int line = index / n;
    int column = index % n;

    for(int k = 0; k < n; k++)
        c[line * n + column] += a[line * n + k] * b[k * n + column];

    return ;
}*/

__global__
void multiply_matrix(int n, Matrix a, Matrix b, Matrix *c)
{
    int index = blockIdx.x * blockDim.x + threadIdx.x;

    int line = index / n;
    int column = index % n;

    for(int k = 0; k < n; k++)
    (*c)[line][column] += a[line][k] * b[k][column];

    return ;
}

int main()
{
    int n = 100;
    Matrix a(100), b(100), *c;
    cudaMallocManaged(&c, sizeof(Matrix));

    new(c)Matrix(100);

    for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
        {
            a[i][j] = (i + j) * 0.01f;
            b[i][j] = (i * i + j * j + 0.2f) * 0.001f;
        }
    }

    multiply_matrix<<<(n + 128 - 1) / 128, 128>>>(n, a, b, c);
    cudaDeviceSynchronize();

    for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
            std::cout << (*c)[i][j] << " ";
        std::cout << "\n";
    }

    cudaFree(c);
    return 0;
}