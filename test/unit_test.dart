

import 'dart:math';

import 'package:fall_24_flutter_course/templates/lab7/calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds two numbers', () {
    final calculator = Calculator();
    expect(calculator.add(1, 2), 3);
  });

  test('subtract two numbers', () {
    final calculator = Calculator();
    expect(calculator.subtract(3, 2), 1);
  });

  test('multiply two numbers', () {
    final calculator = Calculator();
    expect(calculator.multiply(3, 4), 12);
  });

  test('divide two numbers', () {
    final calculator = Calculator();
    expect(calculator.divide(16, 4), 4);
  });

  test('mod two numbers', () {
    final calculator = Calculator();
    expect(calculator.mod(25, 7), 4);
  });

  test('power two numbers', () {
    final calculator = Calculator();
    expect(calculator.power(3, 3), 27);
  });
}