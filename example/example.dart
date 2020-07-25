import 'package:matrix2d/matrix2d.dart';

void main() {
  Matrix2d m2d = Matrix2d();
  List list = [
    [1, 2],
    [1, 2]
  ];
  // Shape
  var shape = m2d.shape(list);
  print(shape);

  // flatten
  var flat = m2d.flatten(list);
  print(flat);

  // transpose
  var transpose = m2d.transpose(list);
  print(transpose);

  // addition
  var add = m2d.addition([
    [1, 1],
    [1, 1]
  ], [
    [2, 2],
    [2, 2]
  ]);
  print(add);

  // subtration
  var sub = m2d.subtraction([
    [1, 1],
    [1, 1]
  ], [
    [2, 2],
    [2, 2]
  ]);
  print(sub);

  // division

  var div = m2d.division([
    [1, 1],
    [1, 1]
  ], [
    [2, 0],
    [2, 2]
  ]);
  print(div);

  // dot operation

  var dot = m2d.dot([
    [1, 2],
    [3, 4]
  ], [
    [11, 12],
    [13, 14]
  ]);
  print(dot);

  // arange

  var arange = m2d.arange(10);
  print(arange);

  // zeros

  var zeros = m2d.zeros(2, 2);
  print(zeros);

  //ones

  var ones = m2d.ones(3, 3);
  print(ones);

  //sum

  var sum = m2d.sum([
    [2, 2],
    [2, 2]
  ]);
  print(sum);

  // reshape
  var reshape = m2d.reshape([
    [0, 1, 2, 3, 4, 5, 6, 7]
  ], 4, 2);
  print(reshape);

  // linspace
  var linspace = m2d.linspace(2, 3, 5);
  print(linspace);
}
