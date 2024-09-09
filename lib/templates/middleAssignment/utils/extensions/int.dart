extension ToTimeString on int {
  String toMinuteWithSecondFormat() =>
      '${(this ~/ 60)._extendedWithZero}:${(this % 60)._extendedWithZero}';

  String get _extendedWithZero =>
      this < 10 ? '0$this' : toString();
}
