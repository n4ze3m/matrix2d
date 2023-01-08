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

  test('test flatten', () {
    expect(m2d.flatten(array), [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 5, 7, 8, 9, 10]);
  });

  test('test transpose with double', () {
    expect(
        m2d.transpose([
          [1.0, 2.0],
          [1.0, 2.0]
        ]),
        [
          [1.0, 1.0],
          [2.0, 2.0]
        ]);
  });

  test('test transpose with int', () {
    expect(
        m2d.transpose([
          [1, 2],
          [1, 2]
        ]),
        [
          [1, 1],
          [2, 2]
        ]);
  });

  test('test transpose with string', () {
    expect(
        m2d.transpose([
          ['1', '2'],
          ['1', '2']
        ]),
        [
          ['1', '1'],
          ['2', '2']
        ]);
  });

  test('test transpose with bool', () {
    expect(
        m2d.transpose([
          [true, false],
          [true, false]
        ]),
        [
          [true, true],
          [false, false]
        ]);
  });

  test('test transpose with dynamic', () {
    expect(
        m2d.transpose([
          [1, '2', true],
          [1, '2', false]
        ]),
        [
          [1, 1],
          ['2', '2'],
          [true, false]
        ]);
  });

  test('test reshape', () {
    expect(m2d.reshape(array, 5, 3), [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [10, 5, 7],
      [8, 9, 10]
    ]);
  });

  test('test #1 with 2 row and column indexs', () {
    expect(m2d.slice(array, [0, 2], [1, 4]), [
      [2, 3, 4],
      [7, 8, 9]
    ]);
  });

  test('test diagonal', () {
    expect(m2d.diagonal(array), [1, 7, 8]);
  });

  test('test concatenate', () {
    expect(
        m2d.concatenate([
          [1, 2],
          [3, 4]
        ], [
          [5, 6]
        ]),
        [
          [1, 2],
          [3, 4],
          [5, 6]
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

  test('test #5 flip matrix axis - 0', () {
    expect(m2d.reverse(array), [
      [5, 7, 8, 9, 10],
      [6, 7, 8, 9, 10],
      [1, 2, 3, 4, 5]
    ]);
  });
  test('test #6 flip matrix axis - 1', () {
    expect(m2d.reverse(array, 1), [
      [5, 4, 3, 2, 1],
      [10, 9, 8, 7, 6],
      [10, 9, 8, 7, 5]
    ]);
  });
}
