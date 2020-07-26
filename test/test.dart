import 'package:matrix2d/matrix2d.dart';

void main() {
  // create a matrix
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
