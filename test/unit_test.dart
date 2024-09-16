

import 'package:fall_24_flutter_course/templates/lab7/calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds two numbers', () {
    final calculator = Calculator();
    expect(calculator.add(2, 2), 4);
  });

  test('subtract two numbers', () {
    final calculator = Calculator();
    expect(calculator.subtract(4, 2), 2);
  });

  test('multiply two numbers', () {
    final calculator = Calculator();
    expect(calculator.multiply(4, 2), 8);
  });

  test('divide two numbers', () {
    final calculator = Calculator();
    expect(calculator.divide(6, 2), 3);
  });

  test('mod two numbers', () {
    final calculator = Calculator();
    expect(calculator.mod(4, 2), 0);
  });

  test('power two numbers', () {
    final calculator = Calculator();
    expect(calculator.power(4, 2), 16);
  });
}