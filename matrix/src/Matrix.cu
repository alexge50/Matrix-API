//
// Created by alex on 12/22/18.
//

#include <Matrix.h>

Matrix::Matrix(int n): m_n(n)
{
    cudaMallocManaged(&m_matrix, n * n * sizeof(float));
}

SubscriptProxy Matrix::operator[](int line)
{
    return SubscriptProxy(m_n, line, m_matrix);
}

SubscriptProxy::SubscriptProxy(int n, int line, float *matrix):
    m_n(n),
    m_line(line),
    m_matrix(matrix)
{}

SubscriptProxy::SubscriptProxy(SubscriptProxy &&other):
    m_matrix(other.m_matrix),
    m_n(other.m_n),
    m_line(other.m_line)
{
    other.m_matrix = nullptr;
    other.m_line = 0;
    other.m_n = 0;
}

float& SubscriptProxy::operator[](int column)
{
    return m_matrix[m_line * m_n + column];
}