import 'package:matrix2d/matrix2d.dart';
import 'package:test/test.dart';

void main() {
  // create a matrix
  Matrix2d m2d = Matrix2d();
  var array = [
    [1, 2, 3, 4, 5],
    [6, 7, 8, 9, 10],
    [5, 7, 8, 9, 10]
  ];

  test('test #1 with 2 row and column indexs', () {
    expect(m2d.slice(array, [0, 2], [1, 4]), [
      [2, 3, 4],
      [7, 8, 9]
    ]);
  });

  test('test #2 with 1 row and 2 column index', () {
    expect(m2d.slice(array, [1, 2], [0]), [6]);
  });

  test('test #3 with 2 row and column indexs', () {
    expect(m2d.slice(array, [0, 4], [2, 3]), [
      [3],
      [8],
      [8]
    ]);
  });

  test('test #4', () {
    expect(m2d.slice(array, [0, 4], [3]), [4, 9, 9]);
  });
}
