//
// Created by alex on 12/22/18.
//

#ifndef MATRIX_COMPUTE_MATRIX_H
#define MATRIX_COMPUTE_MATRIX_H

#include <cuda-indexing.h>

class SubscriptProxy;
class Matrix
{
public:
    Matrix() = delete;
    explicit Matrix(int n);
    Matrix(const Matrix &);
    Matrix(Matrix &&);

    ~Matrix();

    __host__ __device__ SubscriptProxy operator[](int line);

private:
    float *m_matrix;
    int m_n;
};

class MatrixRef
{
private:
    MatrixRef(float *matrix, int n);
public:
    MatrixRef() = delete;
    MatrixRef(const MatrixRef &) = default;
    MatrixRef(MatrixRef &&) = default;

    ~MatrixRef() = default;

    __host__ __device__ SubscriptProxy operator[](int line);

private:
    float *m_matrix;
    int m_n;
};

class SubscriptProxy
{
private:
    __host__ __device__ SubscriptProxy(int n, int line, float *matrix);
    __host__ __device__ SubscriptProxy(SubscriptProxy &&);
    friend Matrix;
    friend MatrixRef;

public:
    SubscriptProxy() = delete;
    SubscriptProxy(const SubscriptProxy &) = delete;

    __host__ __device__ float& operator[](int column);
private:
    int m_n, m_line;
    float *m_matrix;
};

#endif //MATRIX_COMPUTE_MATRIX_H
