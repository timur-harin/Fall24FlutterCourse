import 'package:fall_24_flutter_course/templates/lab7/calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final calculator = Calculator();

  test('adds two numbers', () {
    expect(calculator.add(1, 2), 3);
  });

  test('subtract two numbers', () {
    expect(calculator.subtract(5, 3), 2);
  });

  test('multiply two numbers', () {
    expect(calculator.multiply(4, 3), 12);
  });

  test('divide two numbers', () {
    expect(calculator.divide(8, 4), 2);
  });

  test('mod two numbers', () {
    expect(calculator.mod(10, 3), 1);
  });

  test('power two numbers', () {
    expect(calculator.power(2, 3), 8);
  });
}
