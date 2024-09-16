

import 'dart:math';

import 'package:fall_24_flutter_course/templates/lab7/calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds two numbers', () {
    final calculator = Calculator();
    expect(calculator.add(1, 2), 3);
    expect(calculator.add(2353, 743), 3096);
    expect(calculator.add(-771, 9), -762);
  });

  test('subtract two numbers', () {
    final calculator = Calculator();
    expect(calculator.subtract(3, 2), 1);
    expect(calculator.subtract(74, 80), -6);
    expect(calculator.subtract(1000, 7), 993);
  });

  test('multiply two numbers', () {
    final calculator = Calculator();
    expect(calculator.multiply(3, 4), 12);
    expect(calculator.multiply(25, 25), 625);
    expect(calculator.multiply(1284, 234), 300456);
  });

  test('divide two numbers', () {
    final calculator = Calculator();
    expect(calculator.divide(16, 4), 4);
    expect(calculator.divide(255, 5), 51);
    expect(calculator.divide(43, 1), 43);
  });

  test('mod two numbers', () {
    final calculator = Calculator();
    expect(calculator.mod(25, 7), 4);
    expect(calculator.mod(65, 66), 65);
    expect(calculator.mod(358, 10), 8);
  });

  test('power two numbers', () {
    final calculator = Calculator();
    expect(calculator.power(3, 3), 27);
    expect(calculator.power(73, 4), 28398241);
    expect(calculator.power(2543, 0), 1);
    expect(calculator.power(44, 1), 44);
  });
}