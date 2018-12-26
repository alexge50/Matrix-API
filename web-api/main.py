from flask import Flask, request, jsonify
import matrix

app = Flask(__name__)


@app.route('/')
def hello():
    return 'Hello, World!'


@app.route('/multiply', methods=['POST'])
def multiply():
    order = int(request.form['order'])
    (m1, m2) = (request.form.getlist('m1'), request.form.getlist('m2'))
    first_matrix = [[float(x) for x in m1[row * order:order + row * order]] for row in range(order)]
    second_matrix = [[float(x) for x in m2[row * order:order + row * order]] for row in range(order)]

    return jsonify(matrix.multiply(first_matrix, second_matrix))
