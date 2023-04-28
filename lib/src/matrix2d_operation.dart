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
  /// var sub = m2d.subtraction([[1,1],[1,1]],[[2,2],[2,2]]);
  /// print(sub);
  /// //[[-1,-1],[-1,-1]]
  ///```
  List<dynamic> subtraction(List<dynamic> list1, List<dynamic> list2) {
    var typeOfList1 = m2dType(list1);
    var typeOfList2 = m2dType(list2);

    if (typeOfList1 == M2dType.vector && typeOfList2 == M2dType.vector) {
      if (list1.length != list2.length) {
        throw new Exception(
            'operands could not be broadcast together with shapes ${list1.shape} ${list2.shape}');
      }
      var result = utlsubtraction(list1, list2);
      return result;
    } else if (typeOfList1 == M2dType.matrix && typeOfList2 == M2dType.matrix) {
      var list1Shape = shape(list1);
      var list2Shape = shape(list2);
      if (list1Shape.toString() != list2Shape.toString()) {
        throw new Exception(
            'operands could not be broadcast together with shapes $list1Shape $list2Shape');
      }
      var result = utlsubtraction(list1, list2);
      return result;
    } else if (typeOfList1 == M2dType.matrix && typeOfList2 == M2dType.vector) {
      // subraction of matrix and vector
      var list1Shape = shape(list1);
      var list2Shape = shape(list2);
      if (list1Shape[1] != list2Shape[0]) {
        throw new Exception(
            'operands could not be broadcast together with shapes $list1Shape $list2Shape');
      }
      return utlsubtractionMatrixVector(list1, list2);
    } else if (typeOfList1 == M2dType.vector && typeOfList2 == M2dType.matrix) {
      var list1Shape = shape(list1);
      var list2Shape = shape(list2);
      if (list1Shape[0] != list2Shape[0]) {
        throw new Exception(
            'operands could not be broadcast together with shapes $list1Shape $list2Shape');
      }
      return utlsubtractionMatrixVector(list2, list1);
    } else {
      throw new Exception(
          'operands could not be broadcast together with shapes ${shape(list1)} ${shape(list2)}');
    }
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
  ///
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

  dynamic dot(List<dynamic> a, List<dynamic> b) {
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
}
