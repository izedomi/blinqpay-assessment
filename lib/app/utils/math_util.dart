import 'dart:math';

class MathUtil {
  static int random(int range) {
    Random random = Random();
    return random.nextInt(range);
  }
}
