import 'package:matrix2d/matrix2d.dart';

extension Matrix2dExtension on List {
  /// The shape of an array is the number of elements in each dimension.
  List get shape => Matrix2d().shape(this);

  /// Used to get a copy of an given array collapsed into one dimension
  List get flatten => Matrix2d().flatten(this);

  /// Reverse the axes of an array and returns the modified array.
  List get transpose => Matrix2d().transpose(this);

  /// Function returns the sum of array elements
  dynamic get sum => Matrix2d().sum(this);

  /// To find a diagonal element from a given matrix and gives output as one dimensional matrix
  List get diagonal => Matrix2d().diagonal(this);

  /// Reshaping means changing the shape of an array.
  List reshape(int row, int column) => Matrix2d().reshape(this, row, column);

  /// find min value of given matrix
  List min({int? axis}) => Matrix2d().min(this, axis: axis);

  /// find max value of given matrix
  List max({int? axis}) => Matrix2d().max(this, axis: axis);

  /// flip (`reverse`) the matrix along the given axis and returns the modified array.
  List flip({int? axis}) => Matrix2d().reverse(this, axis);
}
