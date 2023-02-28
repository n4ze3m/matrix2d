part of 'matrix2d.dart';

extension Matrix2DShape on Matrix2d {
  /// The shape of an array is the number of elements in each dimension.
  ///
  /// ```
  /// var shape = m2d.shape([[1, 2],[1, 2]]);
  /// print(shape);
  /// //output [2,2]
  /// ```
  List<int> shape(List<dynamic> list) {
    var _shapeCheck = _checkArray(list);
    if (!_shapeCheck) {
      throw new Exception('Uneven array dimension');
    }
    List<int> result = [];
    for (;;) {
      result.add(list.length);
      if (Matrix2d._isList(list[0])) {
        list = list[0];
      } else {
        break;
      }
    }
    return result;
  }

  /// Reshaping means changing the shape of an array.
  ///
  ///```
  ///var reshape = m2d.reshape([ [0, 1, 2, 3, 4, 5, 6, 7]],2,4);
  ///print(reshape);
  /////[[0, 1, 2, 3], [4, 5, 6, 7]]
  ///```
  /// Reshaping means changing the shape of an array.
  ///
  ///```
  ///var reshape = m2d.reshape([ [0, 1, 2, 3, 4, 5, 6, 7]],2,4);
  ///print(reshape);
  /////[[0, 1, 2, 3], [4, 5, 6, 7]]
  ///```

  List<dynamic> reshape(List list, int row, int column,
      {ReshapeOrder order = ReshapeOrder.C}) {
    var listShape = shape(list);
    if (listShape[0] != 1 || listShape[0] == 1) list = flatten(list);
    var copy = list.sublist(0);
    list.clear();
    if (order == ReshapeOrder.C || order == ReshapeOrder.A) {
      for (var i = 0; i < copy.length; i++) {
        var r = i ~/ column;
        if (list.length <= r) list.add([]);
        list[r].add(copy[i]);
      }
    } else if (order == ReshapeOrder.F) {
      for (var i = 0; i < copy.length; i++) {
        var c = i % column;
        if (list.length <= c) list.add([]);
        list[c].add(copy[i]);
      }
    }
    return list;
  }

  ///Reverse the axes of an array and returns the modified array.
  ///
  ///```
  ///var transpose = m2d.transpose([[1, 2],[1, 2]]);
  ///print(transpose);
  ///// [[1,1],[2,2]]
  ///```
  List<dynamic> transpose(List<dynamic> list) {
    if (!_checkArray(list)) {
      throw new Exception('Matrix2d.transpose: Uneven array dimension');
    }
    var result = List.generate(list[0].length, (index) => []);
    for (var i = 0; i < list.length; i++) {
      for (var j = 0; j < list[i].length; j++) {
        result[j].add(list[i][j]);
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
  List<dynamic> flatten(List<dynamic> list) {
    if (!_checkArray(list)) {
      throw new Exception('Matrix2d.flatten: Uneven array dimension');
    }
    return [for (var sublist in list) ...sublist];
  }
}
