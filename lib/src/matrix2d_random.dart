part of 'matrix2d.dart';

extension Matrix2dRandom on Matrix2d {
  /// Return a matrix of the given shape and populate it with
  ///
  /// random samples from a uniform distribution over [0, 1).
  ///
  /// ```dart
  /// var rand = m2d.rand(2, 3);
  /// print(rand);
  /// //output [[0.3745401188473625, 0.9507143064099162, 0.7319939418114051], [0.5986584841970366, 0.15601864044243652, 0.15599452033620265]]
  /// ```
  List<List<double>> rand(int rows, int cols) {
    var random = Random();
    return List.generate(
        rows,
        (i) => List.generate(cols,
            (j) => (random.nextDouble() * 100000000).round() / 100000000));
  }
}
