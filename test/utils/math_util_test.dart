import 'package:blinqpay/app/utils/math_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("math utils", () {
    test("Generated random number is within givien range", () async {
      final number = MathUtil.random(10);
      expect(number <= 10, true);
    });
  });
}
