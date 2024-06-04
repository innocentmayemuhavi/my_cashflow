import 'dart:math';

String generateRandomString() {
  final Random random = Random();
  const int length = 4;
  const String digits = '0123456789';

  return String.fromCharCodes(Iterable.generate(
      length, (_) => digits.codeUnitAt(random.nextInt(digits.length))));
}
