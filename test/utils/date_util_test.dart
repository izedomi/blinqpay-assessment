import 'package:blinqpay/app/utils/date_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("date utils", () {
    test("Generated random number is within givien range", () async {
      final ago = DateUtil.timeAgo(0000000);
      expect(ago, "55 years ago");
    });
  });
}
