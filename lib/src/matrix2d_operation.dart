part of 'matrix2d.dart';

extension Matrix2dOperation on Matrix2d {
  /// Function is used when we want to compute the addition of two array.
  ///
  ///```
  /// var add = m2d.addition([[1,1],[1,1]],[[2,2],[2,2]]);
  /// print(add);
  /// //[[3,3],[3,3]]
  ///```
  List addition(List<dynamic> list1, List<dynamic> list2) {
    var list1Shape = shape(list1);
    var list2Shape = shape(list2);
    if (list1Shape.toString() != list2Shape.toString()) {
      throw new Exception(
          'operands could not be broadcast together with shapes $list1Shape $list2Shape');
    }
    var result = utladdition(list1, list2);
    return result;
  }

  /// Function is used when we want to compute the difference of two array.
  ///
  ///```
  /// var sub = m2d.subtract([[1,1],[1,1]],[[2,2],[2,2]]);
  /// print(sub);
  /// //[[-1,-1],[-1,-1]]
  ///```
  dynamic subtract(dynamic a, dynamic b) {
    // Determine the type of a and b
    M2dType aType = m2dType(a);
    M2dType bType = m2dType(b);
    // Vector subtract
    if (aType == M2dType.vector && bType == M2dType.vector) {
      if (a.length != b.length) {
        throw ArgumentError("Vector dimensions do not match.");
      }

      List<num> result = List.filled(a.length, 0);
      for (int i = 0; i < a.length; i++) {
        result[i] = a[i] - b[i];
      }
      return result;
    }
    // Number subtract
    if (aType == M2dType.number && bType == M2dType.number) {
      return a - b;
    }
    // Vector-number subtract
    if (aType == M2dType.vector && bType == M2dType.number) {
      List<num> result = List.filled(a.length, 0);
      for (int i = 0; i < a.length; i++) {
        result[i] = a[i] - b;
      }
      return result;
    }
    // Number-vector subtract
    if (aType == M2dType.number && bType == M2dType.vector) {
      List<num> result = List.filled(b.length, 0);
      for (int i = 0; i < b.length; i++) {
        result[i] = a - b[i];
      }
      return result;
    }
    // Matrix subtract
    if (aType == M2dType.matrix && bType == M2dType.matrix) {
      if (a.length != b.length || a[0].length != b[0].length) {
        throw ArgumentError('Matrix dimensions do not match.');
      }

      List<List<num>> result =
          List.generate(a.length, (i) => List.filled(a[i].length, 0));
      for (int i = 0; i < a.length; i++) {
        for (int j = 0; j < a[i].length; j++) {
          result[i][j] = a[i][j] - b[i][j];
        }
      }
      return result;
    }
    // Matrix-vector subtract
    if (aType == M2dType.matrix && bType == M2dType.vector) {
      if (a[0].length != b.length) {
        throw ArgumentError('Matrix dimensions do not match.');
      }

      List<List<num>> result =
          List.generate(a.length, (i) => List.filled(a[0].length, 0));
      for (int i = 0; i < a.length; i++) {
        for (int j = 0; j < b.length; j++) {
          result[i][j] = a[i][j] - b[j];
        }
      }
      return result;
    }
    // Vector-matrix subtract
    if (aType == M2dType.vector && bType == M2dType.matrix) {
      if (a.length != b[0].length) {
        throw ArgumentError('Matrix dimensions do not match.');
      }

      List<List<num>> result =
          List.generate(b.length, (_) => List.filled(b[0].length, 0));
      for (int i = 0; i < b.length; i++) {
        for (int j = 0; j < a.length; j++) {
          result[i][j] = b[i][j] - a[j];
        }
      }
      return result;
    }
    // Matrix-number subtract
    if (aType == M2dType.matrix && bType == M2dType.number) {
      List<List<num>> result =
          List.generate(a.length, (i) => List<num>.filled(a[0].length, 0));

      for (int i = 0; i < a.length; i++) {
        for (int j = 0; j < a[0].length; j++) {
          result[i][j] = a[i][j] - b;
        }
      }
      print("final result is $result");
      return result;
    }
    // Number-matrix subtract
    if (aType == M2dType.number && bType == M2dType.matrix) {
      List<List<num>> result =
          List.generate(b.length, (i) => List<num>.filled(b[0].length, 0));
      for (int i = 0; i < b.length; i++) {
        for (int j = 0; j < b[0].length; j++) {
          result[i][j] = a - b[i][j];
        }
      }

      return result;
    }
    // Invalid input
    throw ArgumentError("Invalid input.");
  }

  /// Matrix element from first matrix is divided by elements from second element.Both list1 and list2 must have same shape and element in list2 must not be zero; otherwise ouput matrix contain infinity.
  ///
  /// ```
  /// var div = m2d.division([[1,1],[1,1]],[[2,0],[2,2]]);
  /// print(div);
  /// // [[0.5, Infinity], [0.5, 0.5]]
  /// ```
  List division(List list1, List list2) {
    var list1Shape = shape(list1);
    var list2Shape = shape(list2);
    if (list1Shape.toString() != list2Shape.toString()) {
      throw new Exception(
          'operands could not be broadcast together with shapes $list1Shape $list2Shape');
    }
    var result = utldivition(list1, list2);
    return result;
  }

  /// Broadcast the Vector
  static List<dynamic> broadcastVector(
      List<dynamic> vector, int broadcastLength) {
    // Returns a copy of the vector with its elements
    // replicated along the broadcast axis.
    return List<dynamic>.generate(
        broadcastLength, (i) => vector[i % vector.length]);
  }

  ///Function returns the dot product of two arrays. For 2-D vectors, it is the equivalent to matrix multiplication. For 1-D arrays, it is the inner product of the vectors. For N-dimensional arrays, it is a sum product over the last axis of a and the second-last axis of b.
  ///
  ///```
  ///var dot = m2d.dot([[1,2],[3,4]], [[11,12],[13,14]])
  ///print(dot);
  /////[[37, 40], [85, 92]]
  ///```
  dynamic dot(dynamic a, dynamic b) {
    // Determine the type of a and b
    M2dType aType = m2dType(a);
    M2dType bType = m2dType(b);

    // Dot product between two vectors
    if (aType == M2dType.vector && bType == M2dType.vector) {
      if (a.length != b.length) {
        throw ArgumentError("Vector dimensions do not match.");
      }

      num sum = 0;
      for (int i = 0; i < a.length; i++) {
        sum += a[i] * b[i];
      }
      return sum;
    }

    // Matrix-vector multiplication
    if (aType == M2dType.matrix && bType == M2dType.vector) {
      if (a[0].length != b.length) {
        throw ArgumentError("Matrix and vector dimensions do not match.");
      }
      List<num> result = List.filled(a.length, 0);
      for (int i = 0; i < a.length; i++) {
        for (int j = 0; j < b.length; j++) {
          result[i] += a[i][j] * b[j];
        }
      }
      return result;
    }

    // Vector-matrix multiplication
    if (aType == M2dType.vector && bType == M2dType.matrix) {
      if (a.length != b.length) {
        throw ArgumentError("Vector and matrix dimensions do not match.");
      }
      List<num> result = List.filled(b[0].length, 0);
      for (int i = 0; i < b[0].length; i++) {
        for (int j = 0; j < b.length; j++) {
          result[i] += a[j] * b[j][i];
        }
      }
      return result;
    }

    // Matrix-matrix multiplication
    if (aType == M2dType.matrix && bType == M2dType.matrix) {
      if (a[0].length != b.length) {
        throw ArgumentError("Matrix dimensions do not match.");
      }
      List<List<num>> result =
          List.generate(a.length, (_) => List.filled(b[0].length, 0));
      for (int i = 0; i < a.length; i++) {
        for (int j = 0; j < b[0].length; j++) {
          for (int k = 0; k < b.length; k++) {
            result[i][j] += a[i][k] * b[k][j];
          }
        }
      }
      return result;
    }

    // num-matrix multiplication
    if (aType == M2dType.number && bType == M2dType.matrix) {
      List<List<num>> result =
          List.generate(b.length, (_) => List.filled(b[0].length, 0));
      for (int i = 0; i < b.length; i++) {
        for (int j = 0; j < b[0].length; j++) {
          result[i][j] = a * b[i][j];
        }
      }
      return result;
    }

    // matrix-num multiplication
    if (aType == M2dType.matrix && bType == M2dType.number) {
      List<List<num>> result =
          List.generate(a.length, (_) => List.filled(a[0].length, 0));
      for (int i = 0; i < a.length; i++) {
        for (int j = 0; j < a[0].length; j++) {
          result[i][j] = a[i][j] * b;
        }
      }
      return result;
    }
    // vector-num multiplication
    if (aType == M2dType.vector && bType == M2dType.number) {
      List<num> result = List.filled(a.length, 0);
      for (int i = 0; i < a.length; i++) {
        result[i] = a[i] * b;
      }
      return result;
    }

    // num-vector multiplication
    if (aType == M2dType.number && bType == M2dType.vector) {
      List<num> result = List.filled(b.length, 0);
      for (int i = 0; i < b.length; i++) {
        result[i] = a * b[i];
      }
      return result;
    }

    // num-num multiplication
    if (aType == M2dType.number && bType == M2dType.number) {
      return a * b;
    }

    // Invalid input
    throw ArgumentError("Invalid input.");
  }

  /// Perform scalar operation on matrix and return the result.
  ///
  /// ```
  /// var scalar = m2d.scalarOperation([[1,2],[3,4]], 2, Operation.add);
  /// print(scalar);
  /// // [[3, 4], [5, 6]]
  /// ```
  @Deprecated("This method should not be used.")
  List<dynamic> scalarOperation(
      List<dynamic> list, dynamic scalar, Operation operation) {
    var type = m2dType(list);
    // check if scalar is a number or List of numbers
    if (scalar is num) {
      if (type == M2dType.matrix) {
        var result = new List<num>.filled(list.length, 0)
            .map((e) => List<num>.filled(list[0].length, 0))
            .toList();

        for (var r = 0; r < list.length; r++) {
          for (var c = 0; c < list[0].length; c++) {
            switch (operation) {
              case Operation.add:
                result[r][c] = list[r][c] + scalar;
                break;
              case Operation.subtract:
                result[r][c] = list[r][c] - scalar;
                break;
              case Operation.divide:
                result[r][c] = list[r][c] / scalar;
                break;
              case Operation.multiply:
                result[r][c] = list[r][c] * scalar;
                break;
              case Operation.mod:
                result[r][c] = list[r][c] % scalar;
                break;
              case Operation.power:
                result[r][c] = pow(list[r][c], scalar);
                break;
              default:
                throw new Exception('Invalid operation');
            }
          }
        }
        return result;
      } else if (type == M2dType.vector) {
        var result = new List<num>.filled(list.length, 0);
        for (var i = 0; i < list.length; i++) {
          switch (operation) {
            case Operation.add:
              result[i] = list[i] + scalar;
              break;
            case Operation.subtract:
              result[i] = list[i] - scalar;
              break;
            case Operation.divide:
              result[i] = list[i] / scalar;
              break;
            case Operation.multiply:
              result[i] = list[i] * scalar;
              break;
            case Operation.mod:
              result[i] = list[i] % scalar;
              break;
            case Operation.power:
              result[i] = pow(list[i], scalar);
              break;
            default:
              throw new Exception('Invalid operation');
          }
        }
        return result;
      } else {
        throw new Exception('Invalid input');
      }
    } else if (scalar is List) {
      if (type == M2dType.matrix) {
        var result = new List<num>.filled(list.length, 0)
            .map((e) => List<num>.filled(list[0].length, 0))
            .toList();

        for (var r = 0; r < list.length; r++) {
          for (var c = 0; c < list[0].length; c++) {
            switch (operation) {
              case Operation.add:
                result[r][c] = list[r][c] + scalar[r][c];
                break;
              case Operation.subtract:
                result[r][c] = list[r][c] - scalar[r][c];
                break;
              case Operation.divide:
                result[r][c] = list[r][c] / scalar[r][c];
                break;
              case Operation.multiply:
                result[r][c] = list[r][c] * scalar[r][c];
                break;
              case Operation.mod:
                result[r][c] = list[r][c] % scalar[r][c];
                break;
              case Operation.power:
                result[r][c] = pow(list[r][c], scalar[r][c]);
                break;
              default:
                throw new Exception('Invalid operation');
            }
          }
        }
        return result;
      } else if (type == M2dType.vector) {
        var result = [];
        for (var i = 0; i < list.length; i++) {
          switch (operation) {
            case Operation.add:
              for (var j = 0; j < scalar.length; j++) {
                result.add(list[i] + scalar[j]);
              }
              break;
            case Operation.subtract:
              for (var j = 0; j < scalar.length; j++) {
                if (scalar[j] is List) {
                  for (var k = 0; k < scalar[j].length; k++) {
                    result.add(list[i] - scalar[j][k]);
                  }
                } else {
                  result.add(list[i] - scalar[j]);
                }
              }
              break;
            case Operation.divide:
              for (var j = 0; j < scalar.length; j++) {
                result.add(list[i] / scalar[j]);
              }
              break;
            case Operation.multiply:
              for (var j = 0; j < scalar.length; j++) {
                result.add(list[i] * scalar[j]);
              }
              break;
            case Operation.mod:
              for (var j = 0; j < scalar.length; j++) {
                result.add(list[i] % scalar[j]);
              }
              break;
            case Operation.power:
              for (var j = 0; j < scalar.length; j++) {
                result.add(pow(list[i], scalar[j]));
              }
              break;
            default:
              throw new Exception('Invalid operation');
          }
        }
        return result;
      } else {
        throw new Exception('Invalid input');
      }
    } else {
      throw new Exception('Invalid input');
    }
  }

  /// Multiply elements wise multiplications
  ///
  dynamic multiply(dynamic a, dynamic b) {
    M2dType aType = m2dType(a);
    M2dType bType = m2dType(b);

    // Number-Number
    if (aType == M2dType.number && bType == M2dType.number) {
      // Multiply two numbers
      return a * b;
    }

    // Vector-Vector
    if (aType == M2dType.vector && bType == M2dType.vector) {
      // Multiply two vectors element-wise
      if (a.length != b.length) {
        throw ArgumentError('Vectors must have the same length');
      }
      List<num> result = [];
      for (int i = 0; i < a.length; i++) {
        result.add(a[i] * b[i]);
      }
      return result;
    }

    // Matrix-Matrix
    if (aType == M2dType.matrix && bType == M2dType.matrix) {
      List<int> aShape = shape(a);
      List<int> bShape = shape(b);

      if (!isBroadcastable(aShape, bShape)) {
        throw ArgumentError(
            'Operands could not be broadcast together with shapes '
            '(${aShape[0]},${aShape[1]}) (${bShape[0]},${bShape[1]})');
      }

      // perform broadcasting if necessary
      int rows = aShape[0] >= bShape[0] ? aShape[0] : bShape[0];
      int cols = aShape[1] >= bShape[1] ? aShape[1] : bShape[1];
      // check dimensions of a and b
      List<List<num>> aBroadcast = broadcast(a, rows, cols);
      List<List<num>> bBroadcast = broadcast(b, rows, cols);

      List<List<num>> result = List.generate(rows, (_) => List.filled(cols, 0));

      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          result[i][j] = aBroadcast[i][j] * bBroadcast[i][j];
        }
      }
      return result;
    }

    // Matrix-Vector
    if (aType == M2dType.matrix && bType == M2dType.vector) {
      List<int> aShape = shape(a);

      int rows = aShape[0];
      int cols = aShape[1];

      if (cols != b.length) {
        throw ArgumentError(
            "Invalid argument(s): Incompatible shapes for matrix-vector multiplication");
      }
      List<List<num>> result = List.generate(rows, (_) => List.filled(cols, 0));

      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          result[i][j] = a[i][j] * b[j];
        }
      }

      return result;
    }

    // Vector-Matrix
    if (aType == M2dType.vector && bType == M2dType.matrix) {
      List<int> bShape = shape(b);

      int rows = bShape[0];
      int cols = bShape[1];

      if (cols != a.length && rows != a.length) {
        throw ArgumentError(
            "Invalid argument(s): Incompatible shapes for matrix-vector multiplication");
      }

      List<List<num>> result = List.generate(rows, (_) => List.filled(cols, 0));

      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          result[i][j] = a[j] * b[i][j];
        }
      }

      return result;
    }

    // Matrix-Number
    if (aType == M2dType.matrix && bType == M2dType.number) {
      List<int> aShape = shape(a);

      int rows = aShape[0];
      int cols = aShape[1];

      List<List<num>> result = List.generate(rows, (_) => List.filled(cols, 0));

      // Multiply matrix with a number
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          result[i][j] = a[i][j] * b;
        }
      }
      return result;
    }

    // Number-Matrix
    if (aType == M2dType.number && bType == M2dType.matrix) {
      List<int> bShape = shape(b);

      int rows = bShape[0];
      int cols = bShape[1];

      List<List<num>> result = List.generate(rows, (_) => List.filled(cols, 0));

      // Multiply matrix with a number
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          result[i][j] = a * b[i][j];
        }
      }
      return result;
    }
    // Vector-Number
    if (aType == M2dType.vector && bType == M2dType.number) {
      List<num> result = [];
      for (int i = 0; i < a.length; i++) {
        result.add(a[i] * b);
      }
      return result;
    }

    // Number-Vector
    if (aType == M2dType.number && bType == M2dType.vector) {
      List<num> result = [];
      for (int i = 0; i < b.length; i++) {
        result.add(a * b[i]);
      }
      return result;
    }

    throw Exception('Invalid input');
  }

  /// Matric power
  ///
  ///
  dynamic power(dynamic a, num b) {
    M2dType aType = m2dType(a);

    // Matrix
    if (aType == M2dType.matrix) {
      List<int> aShape = shape(a);
      if (aShape[0] != aShape[1]) {
        throw ArgumentError('Matrix must be square');
      }
      List<List<num>> result =
          List.generate(aShape[0], (_) => List.filled(aShape[1], 0));
      for (int i = 0; i < aShape[0]; i++) {
        for (int j = 0; j < aShape[1]; j++) {
          result[i][j] = pow(a[i][j], b);
        }
      }
      return result;
    }

    // Vector
    if (aType == M2dType.vector) {
      List<num> result = [];
      for (int i = 0; i < a.length; i++) {
        result.add(pow(a[i], b));
      }
      return result;
    }

    throw Exception('Invalid input');
  }
}
