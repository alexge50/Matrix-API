#include <iostream>
#include "../include/cuda-indexing.h"
#include <Matrix.h>

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
    constexpr int n = 100;
    Matrix a(n), b(n), *c;
    cudaMallocManaged(&c, sizeof(Matrix));

    new(c)Matrix(n);

    for(int i = 0; i < n; i++)
        for(int j = 0; j < n; j++)
            a[i][j] = b[i][j] = (i == j);

    multiply_matrix<<<(n * n + 256 - 1) / 256, 256>>>(n, a, b, c);
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