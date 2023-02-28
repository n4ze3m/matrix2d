part of 'matrix2d.dart';

extension Matrix2dOperation on Matrix2d {
  /// Function is used when we want to compute the addition of two array.
  ///
  ///```
  /// var add = m2d.addition([[1,1],[1,1]],[[2,2],[2,2]]);
  /// print(add);
  /// //[[3,3],[3,3]]
  ///```
  List addition(List list1, List list2) {
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
  List subtraction(List list1, List list2) {
    var list1Shape = shape(list1);
    var list2Shape = shape(list2);
    if (list1Shape.toString() != list2Shape.toString()) {
      throw new Exception(
          'operands could not be broadcast together with shapes $list1Shape $list2Shape');
    }
    var result = utlsubtraction(list1, list2);
    return result;
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

  ///Function returns the dot product of two arrays. For 2-D vectors, it is the equivalent to matrix multiplication. For 1-D arrays, it is the inner product of the vectors. For N-dimensional arrays, it is a sum product over the last axis of a and the second-last axis of b.
  ///
  ///```
  ///var dot = m2d.dot([[1,2],[3,4]], [[11,12],[13,14]])
  ///print(dot);
  /////[[37, 40], [85, 92]]
  ///```
  List dot(List list1, List list2) {
    if (!_checkArray(list1) || !_checkArray(list1)) {
      throw ('Uneven array dimension');
    }
    var list1Shape = shape(list1);
    var list2Shape = shape(list2);
    if (list1Shape.length < 2 || list2Shape.length < 2) {
      throw new Exception(
          'Currently support 2D operations or put that values inside a list of list');
    }

    if (list1Shape[1] != list2Shape[0]) {
      throw new Exception('Shapes not aligned');
    }
    // todo needs to use zero fun
    var result = new List<num>.filled(list1.length, 0)
        .map((e) => List<num>.filled(list2[0].length, 0))
        .toList();
    // list1 x list2 matrix
    for (var r = 0; r < list1.length; r++) {
      for (var c = 0; c < list2[0].length; c++) {
        for (var i = 0; i < list1[0].length; i++) {
          result[r][c] += list1[r][i] * list2[i][c];
        }
      }
    }
    return result;
  }
  /// Perform scalar operation on matrix and return the result. 
  /// 
  /// ```
  /// var scalar = m2d.scalarOperation([[1,2],[3,4]], 2, Operation.add);
  /// print(scalar);
  /// // [[3, 4], [5, 6]]
  /// ```
  List<dynamic> scalarOperation(
      List<dynamic> list, num scalar, Operation operation) {
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
  }
}
