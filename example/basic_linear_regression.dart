import 'package:matrix2d/matrix2d.dart';

void main() {
  Matrix2d m2d = Matrix2d();

  // independent variable
  var X = [1, 2, 3, 4, 5];
  // dependent variable
  var y = [2, 4, 5, 4, 5];

  // calculate the mean of the independent and dependent variables
  var xMean = m2d.mean(X);
  var yMean = m2d.mean(y);

  // ccalculate the slope and intercept of the regression line
  var xMinusMean = m2d.subtract(X, xMean);
  var yMinusMean = m2d.subtract(y, yMean);

  var slope = m2d.sum(m2d.multiply(xMinusMean, yMinusMean)) /
      m2d.sum(m2d.power(xMinusMean, 2));

  var intercept = yMean - slope * xMean;
  // make a prediction for a new value of X
  var newX = 6;
  var prediction = slope * newX + intercept;

  print('prediction is $prediction');
}
