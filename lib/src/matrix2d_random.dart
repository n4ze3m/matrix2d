part of 'matrix2d.dart';

extension Matrix2dRandom on Matrix2d {
  /// Return a matrix of the given shape and populate it with
  ///
  /// random samples from a uniform distribution over [0, 1).
  ///
  ///
  /// [rows] : int
  /// Number of rows in the output.
  /// [cols] : int, optional
  /// Number of columns in the output. If `null`, a one-dimensional array is
  /// [seed] : int, optional
  /// Seed for the random number generator (if `null`, a random seed will be used).
  /// ```dart
  /// var rand = m2d.rand(2, 3);
  /// print(rand);
  /// //output [[0.3745401188473625, 0.9507143064099162, 0.7319939418114051], [0.5986584841970366, 0.15601864044243652, 0.15599452033620265]]
  /// ```
 List<dynamic> rand(int rows, {int? cols, int? seed}) {
  var random = seed != null ? Random(seed) : Random();
  if (cols != null) {
    return List.generate(
      rows,
      (i) => List.generate(
        cols,
        (j) => (random.nextDouble() * 100000000).round() / 100000000,
      ),
    );
  } else {
    return List.generate(
      rows,
      (i) => (random.nextDouble() * 100000000).round() / 100000000,
    );
  }
}


  /// Return a new array of given shape, with zeros
  ///
  /// ```
  /// var zeros = m2d.zeros(2,2);
  /// print(zeros);
  /// //[[0, 0], [0, 0]]
  /// ```
  List zeros(int row, {int? cols}) {
    if (cols != null) {
      return List.filled(row, 0).map((e) => List.filled(cols, 0)).toList();
    } else {
      return List.filled(row, 0);
    }
  }
}
