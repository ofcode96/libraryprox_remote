import 'dart:math';

int generateUniqueId() {
  DateTime now = DateTime.now();
  int milliSecond = now.microsecondsSinceEpoch;

  Random random = Random();
  int randomSuffix = random.nextInt(999999);
  int uniqueId = int.parse("${randomSuffix + milliSecond}");
  return uniqueId;
}
