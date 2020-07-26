import 'package:matrix2d/matrix2d.dart';

void main() {
  Matrix2d m2d = Matrix2d();
  List list = [
    [1, 2],
    [1, 2]
  ];
  // Shape
  print(list.shape);

  // flatten
  print(list.flatten);

  // transpose
  print(list.transpose);

  // addition
  final add = m2d.addition([
    [1, 1],
    [1, 1]
  ], [
    [2, 2],
    [2, 2]
  ]);
  print(add);

  // subtration
  final sub = m2d.subtraction([
    [1, 1],
    [1, 1]
  ], [
    [2, 2],
    [2, 2]
  ]);
  print(sub);

  // division

  final div = m2d.division([
    [1, 1],
    [1, 1]
  ], [
    [2, 0],
    [2, 2]
  ]);
  print(div);

  // dot operation

  final dot = m2d.dot([
    [1, 2],
    [3, 4]
  ], [
    [11, 12],
    [13, 14]
  ]);
  print(dot);

  // arange

  final arange = m2d.arange(10);
  print(arange);

  // zeros

  final zeros = m2d.zeros(2, 2);
  print(zeros);

  //ones

  final ones = m2d.ones(3, 3);
  print(ones);

  //sum

  final sum = [
    [2, 2],
    [2, 2]
  ];
  print(sum.sum);

  // reshape
  final array = [
    [0, 1, 2, 3, 4, 5, 6, 7]
  ];
  print(array.reshape(4, 2));

  // linspace
  final linspace = m2d.linspace(2, 3, 5);
  print(linspace);

  // diagonal
  final arr = [
    [1, 1, 1],
    [2, 2, 2],
    [3, 3, 3]
  ];
  print(arr.diagonal);

  //fill
  final fill = m2d.fill(3, 3, 'matrix2d');
  print(fill);

  // compare object
  final compare = m2d.compareobject(arr, '>', 2);
  print(compare);

  // concatenate

  // axis 0
  final l1 = [
    [1, 1, 1],
    [1, 1, 1],
    [1, 1, 1]
  ];
  final l2 = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
  ];
  final l3 = m2d.concatenate(l1, l2);
  print(l3);

  // axis 1
  final a1 = [
    [1, 1, 1, 1],
    [1, 1, 1, 1],
    [1, 1, 1, 1]
  ];
  final a2 = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ];

  final a3 = m2d.concatenate(a2, a1, axis: 1);
  print(a3);

  // min max
  final numbers = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ];
  print(numbers.min());
  print(numbers.min(axis: 1));
  print(numbers.min(axis: 0));
  print(numbers.max());
  print(numbers.max(axis: 1));
  print(numbers.max(axis: 0));
}
