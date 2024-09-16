import 'dart:math' as math;

class Calculator {
  int add(int a, int b) {
    return a + b;
  }

  int subtract(int a, int b) {
    return a - b;
  }

  int multiply(int a, int b) {
    return a * b;
  }

  int divide(int a, int b) {
    return a ~/ b;
  }

  int mod(int a, int b) {
    return a % b;
  }

  double pow(int a, int b) {
    return math.pow(a, b).toDouble();
  }
}
