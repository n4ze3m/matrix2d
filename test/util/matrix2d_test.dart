import 'package:matrix2d/matrix2d.dart';
import 'package:test/test.dart';

void main() {
  // create a matrix
  Matrix2d m2d = Matrix2d();
  var array = [
    [1, 2, 3, 4, 5],
    [6, 7, 8, 9, 10],
    [5, 7, 8, 9, 10]
  ];

  test('test flatten', () {
    expect(m2d.flatten(array), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 5, 7, 8, 9, 10]);
  });

  test('test transpose with double', () {
    expect(
        m2d.transpose([
          [1.0, 2.0],
          [1.0, 2.0]
        ]),
        [
          [1.0, 1.0],
          [2.0, 2.0]
        ]);
  });

  test('test transpose with int', () {
    expect(
        m2d.transpose([
          [1, 2],
          [1, 2]
        ]),
        [
          [1, 1],
          [2, 2]
        ]);
  });

  test('test transpose with string', () {
    expect(
        m2d.transpose([
          ['1', '2'],
          ['1', '2']
        ]),
        [
          ['1', '1'],
          ['2', '2']
        ]);
  });

  test('test transpose with bool', () {
    expect(
        m2d.transpose([
          [true, false],
          [true, false]
        ]),
        [
          [true, true],
          [false, false]
        ]);
  });

  test('test transpose with dynamic', () {
    expect(
        m2d.transpose([
          [1, '2', true],
          [1, '2', false]
        ]),
        [
          [1, 1],
          ['2', '2'],
          [true, false]
        ]);
  });

  test('test reshape', () {
    expect(m2d.reshape(array, 5, 3), [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [10, 5, 7],
      [8, 9, 10]
    ]);
  });

  test('test #1 with 2 row and column indexs', () {
    expect(m2d.slice(array, [0, 2], [1, 4]), [
      [2, 3, 4],
      [7, 8, 9]
    ]);
  });

  test('test diagonal', () {
    expect(m2d.diagonal(array), [1, 7, 8]);
  });

  test('test concatenate', () {
    expect(
        m2d.concatenate([
          [1, 2],
          [3, 4]
        ], [
          [5, 6]
        ]),
        [
          [1, 2],
          [3, 4],
          [5, 6]
        ]);
  });

  test('test #2 with 1 row and 2 column index', () {
    expect(m2d.slice(array, [1, 2], [0]), [6]);
  });

  test('test #3 with 2 row and column indexs', () {
    expect(m2d.slice(array, [0, 4], [2, 3]), [
      [3],
      [8],
      [8]
    ]);
  });

  test('test #4', () {
    expect(m2d.slice(array, [0, 4], [3]), [4, 9, 9]);
  });

  test('test #5 flip matrix axis - 0', () {
    expect(m2d.reverse(array), [
      [5, 7, 8, 9, 10],
      [6, 7, 8, 9, 10],
      [1, 2, 3, 4, 5]
    ]);
  });
  test('test #6 flip matrix axis - 1', () {
    expect(m2d.reverse(array, 1), [
      [5, 4, 3, 2, 1],
      [10, 9, 8, 7, 6],
      [10, 9, 8, 7, 5]
    ]);
  });

  test(
      'test #8 scalar operation',
      () => {
            expect(
                m2d.scalarOperation([
                  [1, 2],
                  [3, 4]
                ], 2.0, Operation.add),
                [
                  [3.0, 4.0],
                  [5.0, 6.0]
                ])
          });

  test('test #9 scalar operation', () {
    expect(
        m2d.scalarOperation([
          [1, 2],
          [3, 4]
        ], 2.0, Operation.subtract),
        [
          [-1.0, 0.0],
          [1.0, 2.0]
        ]);
  });

  test('test #10 scalar operation', () {
    expect(
        m2d.scalarOperation([
          [1, 2],
          [3, 4]
        ], 2.0, Operation.multiply),
        [
          [2.0, 4.0],
          [6.0, 8.0]
        ]);
  });

  test('test #11 scalar operation', () {
    expect(
        m2d.scalarOperation([
          [1, 2],
          [3, 4]
        ], 2.0, Operation.divide),
        [
          [0.5, 1.0],
          [1.5, 2.0]
        ]);
  });

  test('test #12 scalar operation', () {
    expect(
        m2d.scalarOperation([
          [1, 2],
          [3, 4]
        ], 2.0, Operation.power),
        [
          [1.0, 4.0],
          [9.0, 16.0]
        ]);
  });

  test('test #13 scalar operation', () {
    expect(
        m2d.scalarOperation([
          [1, 2],
          [3, 4]
        ], 2.0, Operation.mod),
        [
          [1.0, 0.0],
          [1.0, 0.0]
        ]);
  });

  test('test #14 mean', () {
    expect(
        m2d.mean([
          [1, 2],
          [3, 4]
        ]),
        2.5);
  });

  test("test #15 mean", () {
    expect(
        m2d.addition([
          [100, 200]
        ], [
          [200, 300]
        ]),
        [
          [300, 500]
        ]);
  });

  test("vector and matrix dot product", () {
    expect(
        m2d.dot([
          [1, 2]
        ], [
          [3],
          [4]
        ]),
        [
          [11]
        ]);
  });

  group('Dot product', () {
    test('Dot product of two 1D vectors', () {
      expect(m2d.dot([1, 2, 3], [4, 5, 6]), equals(32));
    });

    test('Dot product of two 1D vectors with one element', () {
      expect(m2d.dot([5], [2]), equals(10));
    });

    test('Dot product of two 1D vectors with different lengths', () {
      expect(() => m2d.dot([1, 2], [3, 4, 5]), throwsArgumentError);
    });

    test('Dot product of two 2D matrices', () {
      expect(
          m2d.dot([
            [1, 2],
            [3, 4],
            [5, 6]
          ], [
            [7, 8],
            [9, 10]
          ]),
          equals([
            [25, 28],
            [57, 64],
            [89, 100]
          ]));
    });

    test('Dot product of two 2D matrices with one element', () {
      expect(
          m2d.dot([
            [5]
          ], [
            [2]
          ]),
          equals([
            [10]
          ]));
    });

    test('Dot product of two 2D matrices with incompatible dimensions', () {
      expect(
          () => m2d.dot([
                [1, 2],
                [3, 4]
              ], [
                [5, 6]
              ]),
          throwsArgumentError);
    });

    test('Dot product of a 1D vector and a 2D matrix', () {
      expect(
          m2d.dot([
            1,
            2,
            3
          ], [
            [4, 5],
            [6, 7],
            [8, 9]
          ]),
          equals([40, 46]));
    });

    test('Dot product of a 1D vector and a 2D matrix with broadcast', () {
      expect(
          m2d.dot([
            1,
            2
          ], [
            [3, 4],
            [5, 6]
          ]),
          equals([13, 16]));
    });

    test(
        'Dot product of a 1D vector and a 2D matrix with incompatible dimensions',
        () {
      expect(
          () => m2d.dot([
                1,
                2,
                3
              ], [
                [4, 5],
                [6, 7]
              ]),
          throwsArgumentError);
    });

    test('Dot product of a 2D matrix and a 1D vector', () {
      expect(
          m2d.dot([
            [1, 2, 3],
            [4, 5, 6]
          ], [
            7,
            8,
            9
          ]),
          equals([50, 122]));
    });

    test('Dot product of a 2D matrix and a 1D vector with broadcast', () {
      expect(
          m2d.dot([
            [1, 2],
            [3, 4],
            [5, 6]
          ], [
            7,
            8
          ]),
          equals([23, 53, 83]));
    });

    test(
        'Dot product of a 2D matrix and a 1D vector with incompatible dimensions',
        () {
      expect(
          () => m2d.dot([
                [1, 2],
                [3, 4]
              ], [
                5,
                6,
                7
              ]),
          throwsArgumentError);
    });

    test('Dot product of a number and a 2D matrix', () {
      expect(
          m2d.dot(2, [
            [4, 5],
            [6, 7],
            [8, 9]
          ]),
          equals([
            [8, 10],
            [12, 14],
            [16, 18]
          ]));
    });
  });

  group('m2d.subtract tests', () {
    test('subtracts two 1-dimensional vectors of the same length', () {
      expect(m2d.subtract([1, 2], [3, 4]), equals([-2, -2]));
    });

    test(
        'throws an error when trying to subtract two vectors of different lengths',
        () {
      expect(() => m2d.subtract([1, 2], [3]), throwsArgumentError);
    });

    test('subtracts a scalar from a 1-dimensional vector', () {
      expect(m2d.subtract([1, 2], 3), equals([-2, -1]));
    });

    test('subtracts a scalar from a 2-dimensional vector', () {
      expect(
          m2d.subtract([
            [1, 2],
            [3, 4]
          ], 1),
          equals([
            [0, 1],
            [2, 3]
          ]));
    });

    test('subtracts a 1-dimensional vector from a scalar', () {
      expect(m2d.subtract(3, [1, 2]), equals([2, 1]));
    });

    test(
        'subtracts a 1-dimensional vector from a 2-dimensional vector of the same length',
        () {
      expect(
          m2d.subtract([
            [1, 2],
            [3, 4]
          ], [
            1,
            1
          ]),
          equals([
            [0, 1],
            [2, 3]
          ]));
    });

    test(
        'subtracts a 2-dimensional vector from a 1-dimensional vector of the same length',
        () {
      expect(
          m2d.subtract([
            1,
            2
          ], [
            [1, 1],
            [2, 2]
          ]),
          equals([
            [0, -1],
            [1, 0]
          ]));
    });

    test(
        'subtracts a 2-dimensional vector from a 2-dimensional vector of the same dimensions',
        () {
      expect(
          m2d.subtract([
            [1, 2],
            [3, 4]
          ], [
            [2, 1],
            [1, 3]
          ]),
          [
            [-1, 1],
            [2, 1]
          ]);
    });

    test('subtracts a scalar from a matrix', () {
      expect(
          m2d.subtract([
            [1, 2],
            [3, 4]
          ], 1),
          equals([
            [0, 1],
            [2, 3]
          ]));
    });

    test(
        'throws an error when trying to subtract two matrices of different dimensions',
        () {
      expect(
          () => m2d.subtract([
                [1, 2],
                [3, 4]
              ], [
                [1, 2],
                [3]
              ]),
          throwsArgumentError);
    });
  });

  group('m2d.multiply tests', () {
    test('multiplies two vectors', () {
      expect(m2d.multiply([1, 2, 3], [4, 5, 6]), equals([4, 10, 18]));
    });

    test('multiplies a vector and a matrix', () {
      expect(
          m2d.multiply([
            1,
            3
          ], [
            [4, 5],
            [6, 7],
            [8, 9]
          ]),
          equals([
            [4, 15],
            [6, 21],
            [8, 27]
          ]));
    });

    test('multiplies a matrix and a vector', () {
      expect(
          m2d.multiply([
            [1, 2, 3],
            [4, 5, 6]
          ], [
            7,
            8,
            9
          ]),
          equals([
            [7, 16, 27],
            [28, 40, 54]
          ]));
    });

    test('multiplies two matrices', () {
      expect(
          m2d.multiply([
            [1, 2],
            [4, 5]
          ], [
            [7, 8],
            [11, 12]
          ]),
          equals([
            [7, 16],
            [44, 60]
          ]));
    });

    test('throws error for incompatible vector dimensions', () {
      expect(() => m2d.multiply([1, 2, 3], [4, 5]), throwsArgumentError);
    });

    test('throws error for incompatible matrix dimensions', () {
      expect(
          () => m2d.multiply([
                [1, 2, 3],
                [4, 5, 6]
              ], [
                [7, 8],
                [9, 10]
              ]),
          throwsA(TypeMatcher<ArgumentError>()));
    });

    test('throws error for invalid input types', () {
      expect(() => m2d.multiply(1, ''), throwsA(TypeMatcher<ArgumentError>()));
    });

    test('multiplies two matrices of different sizes', () {
      expect(
          () => m2d.multiply([
                [1, 2, 3],
                [4, 5, 6],
                [7, 8, 9]
              ], [
                [10, 11],
                [12, 13],
                [14, 15]
              ]),
          throwsArgumentError);
    });

    test('multiplies matrix by its transpose', () {
      expect(
          m2d.multiply([
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
          ], [
            [1, 4, 7],
            [2, 5, 8],
            [3, 6, 9]
          ]),
          equals([
            [1, 8, 21],
            [8, 25, 48],
            [21, 48, 81]
          ]));
    });

    test('throws error for non-conformable matrices', () {
      expect(
          () => m2d.multiply([
                [1, 2, 3],
                [4, 5, 6]
              ], [
                [7, 8],
                [9, 10]
              ]),
          throwsArgumentError);
    });

    test('multiplies matrices of different data types', () {
      expect(
          m2d.multiply([
            [1.0, 2.0],
            [3.0, 4.0]
          ], [
            [5, 6],
            [7, 8]
          ]),
          equals([
            [5.0, 12.0],
            [21.0, 32.0]
          ]));
    });

    test('multiplies a matrix and a vector', () {
      expect(
          m2d.multiply([
            [1, 2],
            [4, 5],
            [7, 8]
          ], [
            2,
            3
          ]),
          equals([
            [2, 6],
            [8, 15],
            [14, 24]
          ]));
    });

    test('multiplies a matrix and a vector with negative values', () {
      expect(
          m2d.multiply([
            [1, 2],
            [-4, 5],
            [-7, 8]
          ], [
            2,
            -3
          ]),
          equals([
            [2, -6],
            [-8, -15],
            [-14, -24]
          ]));
    });

    test('multiplies a matrix and a vector with 1x1 matrix', () {
      expect(
          m2d.multiply([
            [5]
          ], [
            4
          ]),
          equals([
            [20]
          ]));
    });

    test(
        'throws an error when the number of columns in matrix does not match the number of rows in the vector',
        () {
      expect(
          () => m2d.multiply([
                [1, 2, 3],
                [4, 5, 6]
              ], [
                2,
                3
              ]),
          throwsArgumentError);
    });

    test(
        'throws an error when the number of columns in matrix does not match the number of rows in the vector',
        () {
      expect(
          () => m2d.multiply([
                [1, 2],
                [4, 5],
                [7, 8]
              ], [
                2,
                3,
                4
              ]),
          throwsArgumentError);
    });

    test('multiplies a row vector by a matrix', () {
      expect(
          m2d.multiply([
            1,
            2,
            3
          ], [
            [4, 5, 6],
            [7, 8, 9],
            [10, 11, 12]
          ]),
          equals([
            [4, 10, 18],
            [7, 16, 27],
            [10, 22, 36]
          ]));
    });

    test('multiplies a column vector by a matrix', () {
      expect(
          m2d.multiply([
            [1],
            [2],
            [3]
          ], [
            [4, 5, 6],
            [7, 8, 9],
            [10, 11, 12]
          ]),
          equals([
            [4, 5, 6],
            [14, 16, 18],
            [30, 33, 36]
          ]));
    });

    test('multiplies a column vector by a matrix', () {
      expect(
          m2d.multiply([
            1,
            2
          ], [
            [1, 2],
            [3, 4],
            [5, 6]
          ]),
          equals([
            [1, 4],
            [3, 8],
            [5, 12]
          ]));
    });
  });
}
