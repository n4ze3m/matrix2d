import 'package:matrix2d/matrix2d.dart';

void main() {
  Matrix2d m2d = Matrix2d();
  var list = [
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

  var sum = [
    [2, 2],
    [2, 2]
  ];
  print(sum.sum);

  // reshape
  var array = [
    [0, 1, 2, 3, 4, 5, 6, 7]
  ];
  print(array.reshape(4, 2));

  // linspace
  var linspace = m2d.linspace(2, 3, 5);
  print(linspace);

  // diagonal
  var arr = [
    [1, 1, 1],
    [2, 2, 2],
    [3, 3, 3]
  ];
  print(arr.diagonal);

  //fill
  var fill = m2d.fill(3, 3, 'matrix2d');
  print(fill);

  // compare object
  var compare = m2d.compare(arr,'>=', 2);
  print(compare);

  // concatenate

  // axis 0
  var l1 = [
    [1, 1, 1],
    [1, 1, 1],
    [1, 1, 1]
  ];
  var l2 = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
  ];
  var l3 = m2d.concatenate(l1, l2);
  print(l3);

  // axis 1
  var a1 = [
    [1, 1, 1, 1],
    [1, 1, 1, 1],
    [1, 1, 1, 1]
  ];
  var a2 = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ];

  var a3 = m2d.concatenate(a2, a1, axis: 1);
  print(a3);

  // slice
  var sliceArray = [
    [1, 2, 3, 4, 5],
    [6, 7, 8, 9, 10],
    [6, 7, 8, 9, 10]
  ];

  var newArray = m2d.slice(sliceArray, [0, 2], [1, 4]);
  print(" sliced array: ${newArray}");

  // min max
  var numbers = [
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
