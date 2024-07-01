import 'package:blinqpay/app/repository/interfaces/user_repository_interface.dart';
import 'package:blinqpay/app/services/users/interfaces/user_service_interface.dart';
import 'package:blinqpay/app/utils/text_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("text utils", () {
    test("get initials from full name", () async {
      expect(TextUtil.getInitialsFromFullname("Izedomi Emmanuel"), "IE");
    });

    test("full name is empty, return empty string", () async {
      expect(TextUtil.getInitialsFromFullname(""), "");
    });

    test("full name has atleast 1 character, return single character initials",
        () async {
      expect(TextUtil.getInitialsFromFullname("Izedomi"), "I");
    });
  });
}
