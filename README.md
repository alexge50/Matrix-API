# Matrix-API

## Description
Matrix-API is the least useful web-api, it has as input 2 square matrices and their order and outputs the product.

## Input
* m1 - first square matrix
* m2 - second square matrix
* order - the order for the square matrices

## Example

```python
>>> input = {'m1':[[1, 0, 0], [0, 1, 0], [0, 0, 1]], 'm2':[[1, 0, 0], [0, 1, 0], [0, 0, 1]], 'order': 3}
>>> r = requests.post('http://127.0.0.1:5000/multiply', data=input)
>>> r.text
'[[1.0,0.0,0.0],[0.0,1.0,0.0],[0.0,0.0,1.0]]\n'
```
