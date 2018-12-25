//
// Created by alex on 12/22/18.
//

#include <Matrix.h>
#include <cuda-indexing.h>
#include "../include/Matrix.h"

#include <cstring>
#include <utility>

Matrix::Matrix(int n): m_n(n)
{
    cudaMallocManaged(&m_matrix, m_n * m_n * sizeof(float));

    std::memset(m_matrix, 0, m_n * m_n * sizeof(float));
}

Matrix::Matrix(const Matrix &other)
{
    m_n = other.m_n;
    cudaMallocManaged(&m_matrix, m_n * m_n * sizeof(float));

    std::memcpy(m_matrix, other.m_matrix, m_n * m_n * sizeof(float));
}

Matrix::Matrix(Matrix &&other):
    m_matrix(other.m_matrix),
    m_n(other.m_n)
{
    other.m_matrix = nullptr;
    other.m_n = 0;
}

Matrix::~Matrix()
{
    cudaFree(m_matrix);
}

__host__ __device__ SubscriptProxy Matrix::operator[](int line)
{
    return SubscriptProxy(m_n, line, m_matrix);
}

int Matrix::order() const
{
    return m_n;
}

MatrixRef &&Matrix::ref() {
    return std::move(MatrixRef(m_matrix, m_n));
}

MatrixRef::MatrixRef(float *matrix, int n):
    m_matrix(matrix),
    m_n(n)
{}

__host__ __device__ SubscriptProxy MatrixRef::operator[](int line)
{
    return SubscriptProxy(m_n, line, m_matrix);
}

int MatrixRef::order() const
{
    return m_n;
}

__host__ __device__ SubscriptProxy::SubscriptProxy(int n, int line, float *matrix):
    m_n(n),
    m_line(line),
    m_matrix(matrix)
{}

__host__ __device__ SubscriptProxy::SubscriptProxy(SubscriptProxy &&other):
    m_matrix(other.m_matrix),
    m_n(other.m_n),
    m_line(other.m_line)
{
    other.m_matrix = nullptr;
    other.m_line = 0;
    other.m_n = 0;
}

__host__ __device__ float& SubscriptProxy::operator[](int column)
{
    return m_matrix[m_line * m_n + column];
}