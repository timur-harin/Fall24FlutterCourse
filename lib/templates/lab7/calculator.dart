import 'dart:math';

class Calculator {
  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;
  int multiply(int a, int b) => a * b;
  int divide(int a, int b) => a ~/ b;
  int mod(int a, int b) => a % b;
  int power(int a, int b) => pow(a, b) as int;
}
