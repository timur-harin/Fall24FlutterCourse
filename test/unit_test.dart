import 'package:fall_24_flutter_course/templates/lab7/calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adds two numbers', () {
    final calculator = Calculator();
    expect(calculator.add(1, 2), 3);
  });

  test('subtract two numbers', () {
    final calculator = Calculator();

    expect(calculator.subtract(15, 12), 3);
  });

  test('multiply two numbers', () {
    final calculator = Calculator();
    
    expect(calculator.multiply(2, 3), 6);
  });

  test('divide two numbers', () {
    final calculator = Calculator();
    
    expect(calculator.divide(27, 3), 9);
  });

  test('mod two numbers', () {
    final calculator = Calculator();
    
    expect(calculator.mod(15, 4), 3);
  });

  test('power two numbers', () {
    final calculator = Calculator();
    
    expect(calculator.pow(5, 3), 125);
  });
}