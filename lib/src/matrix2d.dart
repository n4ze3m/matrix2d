import 'util/util.dart';

/// Dart package for 2D Matrix or 2D array operations
///
/// ```
/// Matrix2d m2d = Matrix2d();
/// ```
class Matrix2d {
  /// Dart package for 2D Matrix or 2D array operations
  ///
  /// ```
  /// Matrix2d m2d = Matrix2d();
  /// ```
  const Matrix2d();

  /// Check the given list is 2D array
  bool _checkArray(List list) {
    var flag = _isList(list[0]);
    var length = flag ? list[0].length : 0;
    for (var i = 0; i < list.length; i++) {
      var tempFlag = _isList(list[i]);
      var tempLength = tempFlag ? list[i].length : 0;
      if (flag != tempFlag || length != tempLength) return false;
    }
    return true;
  }

  /// For checking multi list
  static bool _isList(list) => list is List;

  /// The shape of an array is the number of elements in each dimension.
  ///
  /// ```
  /// var shape = m2d.shape([[1, 2],[1, 2]]);
  /// print(shape);
  /// //output [2,2]
  /// ```
  List shape(List list) {
    var _shapeCheck = _checkArray(list);
    if (!_shapeCheck) throw new Exception('Uneven array dimension');
    var result = [];
    for (;;) {
      result.add(list.length);
      if (_isList(list[0])) {
        list = list[0];
      } else {
        break;
      }
    }
    return result;
  }

  ///  Used to get a copy of an given array collapsed into one dimension
  ///
  /// ```
  /// var flat = m2d.flatten([[1, 2],[1, 2]]);
  /// print(flat);
  /// // [1,2,1,2]
  /// ```
  List flatten(List list) {
    final _shapeCheck = _checkArray(list);
    if (!_shapeCheck) throw new Exception('Uneven array dimension');
    var result = [];
    for (var i = 0; i < list.length; i++) {
      if (list[i] is List) {
        result.addAll(list[i]);
      } else {
        result.add(list[i]);
      }
    }
    return result;
  }

  ///Reverse the axes of an array and returns the modified array.
  ///
  ///```
  ///var transpose = m2d.transpose([[1, 2],[1, 2]]);
  ///print(transpose);
  ///// [[1,1],[2,2]]
  ///```
  List transpose(List list) {
    if (!_checkArray(list)) throw new Exception('Uneven array dimension');
    var result = [];
    for (var i = 0; i < list[0].length; i++) {
      var temp = [];
      for (var j = 0; j < list.length; j++) {
        temp.add(list[j][i]);
      }
      result.add(temp);
    }
    return result;
  }

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

  ///Is one of the array creation routines based on numerical ranges. It creates an instance of ndarray with evenly spaced values and returns the reference to it.
  ///
  ///```
  ///var arange =  m2d.arange(10);
  ///print(arange);
  /////[[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]]
  ///```
  List arange(int stop, [int? start, int? steps]) {
    if (steps == null) steps = 1;
    if (start == null) start = 0;
    List result = [];
    for (var i = start; i <= stop; i += steps) {
      result.add(i);
    }
    return [result];
  }

  /// Return a new array of given shape, with zeros
  ///
  /// ```
  /// var zeros = m2d.zeros(2,2);
  /// print(zeros);
  /// //[[0, 0], [0, 0]]
  /// ```
  List zeros(int row, int cols) =>
      List.filled(row, 0).map((e) => List.filled(cols, 0)).toList();

  /// Return a new array of given shape, with ones
  ///
  /// ```
  /// var ones = m2d.ones(3,3);
  /// print(ones);
  /// //[[1, 1, 1], [1, 1, 1], [1, 1, 1]]
  /// ```
  List ones(int row, int cols) =>
      List.filled(row, 1).map((e) => List.filled(cols, 1)).toList();

  ///Function returns the sum of array elements
  ///
  ///```
  /// var sum =  m2d.sum([[2,2],[2,2]]);
  /// print(sum);
  /// //8
  ///```
  num sum(List list) {
    var listShape = shape(list);
    if (listShape[0] != 1 || listShape[0] == 1) list = this.flatten(list);
    return utlArrSum(list);
  }

  /// Reshaping means changing the shape of an array.
  ///
  ///```
  ///var reshape = m2d.reshape([ [0, 1, 2, 3, 4, 5, 6, 7]],2,4);
  ///print(reshape);
  /////[[0, 1, 2, 3], [4, 5, 6, 7]]
  ///```
  List reshape(List list, int row, int column) {
    var listShape = shape(list);
    if (listShape[0] != 1 || listShape[0] == 1) list = flatten(list);
    var copy = list.sublist(0);
    list.clear();
    for (var i = 0; i < copy.length; i++) {
      var r = i ~/ column;
      if (list.length <= r) list.add([]);
      list[r].add(copy[i]);
    }
    return list;
  }

  ///Returns number spaces evenly w.r.t interval. Similar to arange but instead of step it uses sample number.
  ///
  ///```
  ///var linspace = m2d.linspace(2, 3, 5);
  ///print(linspace);
  /////[2.0, 2.25, 2.5, 2.75, 3.0]
  ///```
  linspace(int start, int end, [int number = 50]) {
    var res = [];
    var steps = (end - start) / (number - 1);
    for (var i = 0; i < number; i++) {
      res.add(start + steps * i);
    }
    return res;
  }

  ///To find a diagonal element from a given matrix and gives output as one dimensional matrix.
  ///
  ///```
  ///var arr = [[1,1,1],[2,2,2],[3,3,3]];
  ///var diagonal = m2d.diagonal(arr);
  ///print(diagonal);
  /////[[1,2,3]]
  ///```
  List diagonal(List list) {
    final shape = this.shape(list);
    var res = [];
    if (shape.length < 2) {
      throw ('Currently support 2D operations or put that values inside a list of list');
    }
    for (var i = 0; i < shape[0]; i++) {
      res.add(list[i][i]);
    }
    return res;
  }

  /// Just like `zeros()` and `ones()` this function will return a new array of given shape, with given object(anything btw strings too)
  ///
  ///```
  ///var fill = m2d.fill(2,2,true);
  ///print(fill);
  ///// [[true,true],[true,true]]
  ///```
  List fill(int row, int cols, value) =>
      List.filled(row, value).map((e) => List.filled(cols, value)).toList();

  /// compare values inside an array with given object and operations. function will return a  new boolen array
  /// ```
  /// var arr = [[1,1,1],[2,2,2],[3,3,3]];
  /// var compare = m2d.compare(arr,'>',2);
  ///print(compare);
  /////[[false, false, false], [false, false, false], [true, true, true]]
  /// ```
  @Deprecated('Use `compare` instead.')
  List compareobject(List list, String operations, object) {
    var shapee = shape(list);
    var operatns = ['>', '<', '>=', '<=', '==', '!='];
    if (!_checkArray(list)) throw new Exception('Uneven array dimension');
    if (!operatns.contains(operations))
      throw new Exception('Current operation is not support');
    if (shapee.length < 2)
      throw new Exception(
          'Currently support 2D operations or put that values inside a list of list');
    var res = fill(shapee[0], shapee[1], true);
    for (var i = 0; i < shapee[0]; i++) {
      for (var j = 0; j < shapee[1]; j++) {
        try {
          var val = list[i][j];
          if (operations == operatns[0]) {
            if (val > object) {
              res[i][j] = true;
            } else {
              res[i][j] = false;
            }
          } else if (operations == operatns[1]) {
            if (val < object) {
              res[i][j] = true;
            } else {
              res[i][j] = false;
            }
          } else if (operations == operatns[2]) {
            if (val >= object) {
              res[i][j] = true;
            } else {
              res[i][j] = false;
            }
          } else if (operations == operatns[3]) {
            if (val <= object) {
              res[i][j] = true;
            } else {
              res[i][j] = false;
            }
          } else if (operations == operatns[4]) {
            if (val == object) {
              res[i][j] = true;
            } else {
              res[i][j] = false;
            }
          } else {
            if (val != object) {
              res[i][j] = true;
            } else {
              res[i][j] = false;
            }
          }
        } catch (e) {
          throw new Exception(
              'Sorry can\'t compare string with number (Not javascript)');
        }
      }
    }
    return res;
  }

  /// compare values inside an array with given object and operations. function will return a  new boolen array
  /// ```
  /// var arr = [[1,1,1],[2,2,2],[3,3,3]];
  /// var compare = m2d.compare(arr,'>',2);
  ///print(compare);
  /////[[false, false, false], [false, false, false], [true, true, true]]
  /// ```
  List compare(List list, String operation, object) {
    var shapee = this.shape(list);
    if (!_checkArray(list)) {
      throw new Exception('Uneven array dimension');
    }

    if (shapee.length < 2) {
      throw new Exception(
          'Currently support 2D operations or put that values inside a list of list');
    }
    var res = fill(shapee[0], shapee[1], true);
    for (var i = 0; i < shapee[0]; i++) {
      for (var j = 0; j < shapee[1]; j++) {
        try {
          var val = list[i][j];
          switch (operation) {
            case '>':
              res[i][j] = val > object;
              break;
            case '<':
              res[i][j] = val < object;
              break;
            case '>=':
              res[i][j] = val >= object;
              break;
            case '<=':
              res[i][j] = val <= object;
              break;
            case '==':
              res[i][j] = val == object;
              break;
            case '!=':
              res[i][j] = val != object;
              break;
            default:
              throw new Exception('Current operation is not support');
          }
        } catch (e) {
          throw new Exception(
              'Sorry can\'t compare string with number (Not javascript)');
        }
      }
    }
    return res;
  }

  /// Concatenation refers to joining. This function is used to join two arrays of the same shape along a specified axis. The function takes the following parameters
  /// note: Axis along which arrays have to be joined. Default is 0
  /// note 2: concatenation of n number of arrays comming soon.....
  List concatenate(List list1, list2, {int axis = 0}) {
    if (axis > 1 || axis < 0) {
      throw ('axis only support 0 and 1');
    }
    var shape1 = shape(list1);
    var shape2 = shape(list2);
    if (axis == 1) {
      if (shape1[0] == shape2[0]) {
        var temp = fill(shape1[0], shape1[1] + shape2[1], null);
        for (var i = 0; i < shape1[0]; i++) {
          temp[i] = list1[i] + list2[i];
        }
        return temp;
      } else {
        throw ('all the input array dimensions for the concatenation axis must match exactly');
      }
    } else {
      if (shape1[1] == shape2[1]) {
        return list1 + list2;
      } else {
        throw new Exception(
            'all the input array dimensions for the concatenation axis must match exactly');
      }
    }
  }

  /// Functions, used to find the maximum value for any given array
  ///
  /// axis is null by default to find min values of columns use zero and for rows use 1
  List min(List list, {int? axis}) {
    try {
      if (!_checkArray(list)) throw new Exception('Not 2d array');
      var result = [];
      if (axis == null) {
        list = flatten(list);
        return [utlArrMin(list)];
      } else if (axis > 1 || axis < 0) {
        //err
        throw Exception('Only two axis 0 and 1');
      } else {
        if (axis == 1) {
          for (var i = 0; i < list.length; i++) {
            if (_isList(list[i])) {
              result.add(utlArrMin(list[i]));
            }
          }
          return result;
        } else {
          list = transpose(list);
          for (var i = 0; i < list.length; i++) {
            if (_isList(list[i])) {
              result.add(utlArrMin(list[i]));
            }
          }
          return result;
        }
      }
    } catch (e) {
      throw Exception('Only two axis 0 and 1');
    }
  }

  /// Functions, used to find the maximum value for any given array
  ///
  /// axis is null by default to find max values of columns use zero and for rows use 1
  List max(List list, {int? axis}) {
    try {
      if (!_checkArray(list)) {
        throw new Exception('Not 2d array');
      }
      var result = [];
      if (axis == null) {
        list = flatten(list);
        return [arrMax(list)];
      } else if (axis > 1 || axis < 0) {
        throw new Exception('Only two axis 0 and 1');
      } else {
        if (axis == 1) {
          for (var i = 0; i < list.length; i++) {
            if (_isList(list[i])) {
              result.add(arrMax(list[i]));
            }
          }
          return result;
        } else {
          list = transpose(list);
          for (var i = 0; i < list.length; i++) {
            if (_isList(list[i])) {
              result.add(arrMax(list[i]));
            }
          }
          return result;
        }
      }
    } catch (e) {
      throw new Exception(e);
    }
  }

  /// Function used to reverse 2D array along axis
  /// axis is 0 by default and only support 0 and 1
  /// ```dart
  /// var arr = [[1,2,3],[4,5,6],[7,8,9]];
  /// var res = m2d.reverse(arr);
  /// print(res);
  /// // [[7,8,9],[4,5,6],[1,2,3]]
  /// ```
  List reverse(List<dynamic> list, [axis = 0]) {
    if (axis == 0) {
      return list.reversed.toList();
    } else if (axis == 1) {
      var temp = [];
      list.forEach((element) {
        temp.add(element.reversed.toList());
      });
      return temp;
    } else {
      throw new Exception('Only two axis 0 and 1');
    }
  }

  /// Function used to slice two-dimensional arrays
  ///
  /// slice(parent array, row_index [start, stop], column_index [start, stop])
  /// ```dart
  /// var array = [[1, 2, 3, 4, 5],[6, 7, 8, 9, 10]];
  ///
  /// print(m2d.slice(array, [0, 2], [1, 4]))
  ///
  /// // output  [[2,3,4], [7,8,9]]
  /// ```
  List slice(List<dynamic> array, List<int> row_index,
      [List<int>? column_index]) {
    var result = [];
    // convert List<dynamic> to List<List>
    var arr = array.map((e) => e is List ? e : [e]).toList();
    try {
      if (row_index.length > 2) {
        throw Exception(
            'row_index only containing the elements between start and end.');
      }
      int rowMin = row_index[0];
      int rowMax = row_index[1];
      int counter = 0;
      arr.forEach((List row) {
        if (rowMin <= counter && counter < rowMax) {
          if (column_index != null && column_index.length > 1) {
            result.add(row.getRange(column_index[0], column_index[1]).toList());
          } else if (column_index == null) {
            result.add(row);
          } else {
            if (result.isEmpty) {
              result = [row[column_index[0]]];
            } else {
              result.add(row[column_index[0]]);
            }
          }
        }
        counter++;
      });
      return result;
    } catch (e) {
      throw new Exception(e);
    }
  }
}
