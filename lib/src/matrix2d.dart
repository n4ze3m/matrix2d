import 'package:matrix2d/matrix2d.dart';

import 'util/util.dart';
import 'dart:math';

/// parts of matrix2d library
part 'matrix2d_shape.dart';
part 'matrix2d_random.dart';
part 'matrix2d_operation.dart';

/// Dart package for 2D Matrix or 2D array operations
///
/// ```
/// Matrix2d m2d = Matrix2d();
/// ```
///
/// ReshapeOrder is used to specify the order in which the values are filled in the reshaped array. C means to fill the values in row-major order, with the last axis index changing fastest, back to the first axis index changing slowest. F means to fill the values in column-major order, with the first index changing fastest, and the last index changing slowest.
enum ReshapeOrder { C, F, A }

/// Operation is used to specify the operation to be performed on the array.
enum Operation { add, subtract, multiply, divide, power, mod }

/// M2dType is used to specify the type of the array.
enum M2dType { vector, matrix, number }

class Matrix2d {
  /// Dart package for 2D Matrix or 2D array operations
  ///
  /// ```
  /// Matrix2d m2d = Matrix2d();
  /// ```
  const Matrix2d();

  /// Return the Matrix2d type of the given list
  /// ```
  /// var list = [
  ///  [1, 2],
  /// [1, 2]
  /// ];
  /// print(m2d.m2dType(list));
  /// //output M2dType.matrix
  M2dType m2dType(dynamic m2d) {
    if (m2d is num) {
      return M2dType.number;
    } else if (m2d is List<num>) {
      return M2dType.vector;
    } else if (m2d is List<List<num>>) {
      return M2dType.matrix;
      // ignore: unnecessary_type_check
    } else if (m2d is List) {
      if (m2d.isEmpty) {
        throw ArgumentError("Invalid input.");
      }
      var firstElement = m2d[0];
      if (firstElement is num) {
        return M2dType.vector;
      }
      M2dType elementType = m2dType(firstElement);
      for (int i = 1; i < m2d.length; i++) {
        if (m2dType(m2d[i]) != elementType) {
          throw ArgumentError("Invalid input.");
        }
      }
      if (elementType == M2dType.vector) {
        return M2dType.matrix;
      } else {
        throw ArgumentError("Invalid input.");
      }
    } else {
      throw ArgumentError("Invalid input.");
    }
  }

  /// Check the given list is 2D array
  bool _checkArray(List list) {
    if (list.isEmpty) {
      return true;
    }

    var flag = list[0] is List;
    var length = flag ? list[0].length : 0;

    for (var item in list) {
      var tempFlag = item is List;
      var tempLength = tempFlag ? item.length : 0;
      if (flag != tempFlag || length != tempLength) {
        return false;
      }
    }

    return true;
  }

  /// For checking multi list
  static bool _isList(list) => list is List;

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
  num sum(dynamic a) {
    if (a is List<num>) {
      return a.reduce((value, element) => value + element);
    } else if (a is List<List<num>>) {
      return a.map((e) => sum(e)).reduce((value, element) => value + element);
    } else {
      throw ArgumentError("Invalid input.");
    }
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

  /// Function used to find the sum of all elements in the given array
  /// ```dart
  /// var arr = [[1,2,3],[4,5,6],[7,8,9]];
  /// print(m2d.mean(arr));
  /// // 5
  /// ```
  double mean(List<dynamic> list) {
    var type = m2dType(list);
    if (type == M2dType.matrix) {
      list = flatten(list);
    }
    var sum = 0.0;
    list.forEach((element) {
      sum += element;
    });
    return sum / list.length;
  }
}
