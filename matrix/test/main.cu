#include <iostream>
#include <Matrix.h>
#include <Multiplication.h>

int main()
{
    constexpr int n = 100;
    Matrix a(n), b(n);

    for(int i = 0; i < n; i++)
        for(int j = 0; j < n; j++)
            a[i][j] = b[i][j] = (i == j);

    Matrix c = multiply_matrix(a, b);

    for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
            std::cout << c[i][j] << " ";
        std::cout << "\n";
    }

    return 0;
}