#include <Multiplication.h>

#include <cassert>
#include <utility>
#include "../include/Matrix.h"

#include <iostream>

__global__
static void kernel_multiply_matrix(MatrixRef a, MatrixRef b, MatrixRef c)
{
    int index = blockIdx.x * blockDim.x + threadIdx.x;

    int line = index / a.order();
    int column = index % a.order();

    for(int k = 0; k < a.order(); k++)
        c[line][column] += a[line][k] * b[k][column];

    return ;
}

Matrix multiply_matrix(Matrix &a, Matrix &b)
{
    assert(a.order() == b.order());
    Matrix c(a.order());

    MatrixRef refC = c.ref();
    kernel_multiply_matrix
        <<<(a.order() * a.order() + 256 - 1) / 256, 256>>>
        (
            a.ref(),
            b.ref(),
            refC
        );
    cudaDeviceSynchronize();

    return std::move(c);
}