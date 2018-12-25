//
// Created by alex on 12/25/18.
//

#include <boost/python.hpp>
#include <Matrix.h>
#include <Multiplication.h>

using namespace boost::python;


Matrix convertToMatrix(const list &a)
{
    Matrix m(len(a));

    int n = len(a);
    for(int i = 0; i < n; i++)
        for(int j = 0; j < n; j++)
            m[i][j] = extract<float>(list(a[i])[j]);

    return m;
}

list convertToList(Matrix &m)
{
    list a{};

    for(int i = 0; i < m.order(); i++)
    {
        list row{};
        for(int j = 0; j < m.order(); j++)
            row.append(m[i][j]);
        a.append(row);
    }

    return a;
}

list multiply(list l1, list l2)
{
    Matrix a = convertToMatrix(l1), b = convertToMatrix(l2);
    Matrix c = multiply_matrix(a, b);

    return convertToList(c);
}

BOOST_PYTHON_MODULE(matrix)
{
    def("multiply", multiply, "multiply 2 matrices");
}