import 'dart:math';

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

  // Added power function
  int power(int base, int exponent) {
    return pow(base, exponent).toInt();
  }
}
