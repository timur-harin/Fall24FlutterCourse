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

  int power(int a, int b) {
    int resp = 1;
    for (var i = 0; i < b; i++) {
      resp *= a;
    }
    return resp;
  }
}
