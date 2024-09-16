

import 'package:fall_24_flutter_course/templates/lab7/calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds two numbers', () {
    final calculator = Calculator();
    expect(calculator.add(1, 2), 3);
  });

  test('subtract two numbers', () {
    final calculator = Calculator();
    expect(calculator.subtract(5, 2), 3);

  });

  test('multiply two numbers', () {
    final calculator = Calculator();
    expect(calculator.multiply(3, 5), 15);
  });

  test('divide two numbers', () {
    final calculator = Calculator();
    expect(calculator.divide(8, 4), 2);
  });

  test('mod two numbers', () {
    final calculator = Calculator();
    expect(calculator.mod(8, 3), 2);
  });

  test('power two numbers', () {
    final calculator = Calculator();
    expect(calculator.power(2, 4), 16);
  });
}