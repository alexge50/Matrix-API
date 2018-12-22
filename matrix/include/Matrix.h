//
// Created by alex on 12/22/18.
//

#ifndef MATRIX_COMPUTE_MATRIX_H
#define MATRIX_COMPUTE_MATRIX_H

class SubscriptProxy;
class Matrix
{
public:
    Matrix() = delete;
    __host__ explicit Matrix(int n);

    __device__ __host__ SubscriptProxy operator[](int line);

private:
    float *m_matrix;
    int m_n;
};

class SubscriptProxy
{
private:
    __device__ __host__ SubscriptProxy(int n, int line, float *matrix);
    __device__ __host__ SubscriptProxy(SubscriptProxy &&);
    friend Matrix;

public:
    SubscriptProxy() = delete;
    SubscriptProxy(const SubscriptProxy &) = delete;

    __device__ __host__ float& operator[](int column);
private:
    int m_n, m_line;
    float *m_matrix;
};


#endif //MATRIX_COMPUTE_MATRIX_H
