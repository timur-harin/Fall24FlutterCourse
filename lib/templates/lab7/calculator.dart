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

  int pow(int a, int b)
  {
    int result = 1;
    for (int i = 0; i < b; i++)
    {
      result*=a;
    }

    return result;
  }
}