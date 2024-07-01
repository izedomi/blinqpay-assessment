import 'package:blinqpay/models/api_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../view_models/user_view_model_test.mocks.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUserServiceInterface mockUserService;

  setUp(() {
    mockUserService = MockUserServiceInterface();
  });

  group("post service", () {
    test("posts is fetch successfully", () async {
      final data = [
        {
          "userId": "blinq001",
          "username": "izedomi",
          "name": "Emmanuel Izedomi",
          "photo": "https://blinq.io",
          "bio": "Learing is awesome!"
        }
      ];
      when(mockUserService.getUsers()).thenAnswer(
          (_) async => ApiResponse(success: true, code: 200, data: data));

      final response = await mockUserService.getUsers();

      expect(response.code, 200);
      expect(response.success, true);
      expect(response.data, data);
    });
  });

  test("error fetching posts", () async {
    when(mockUserService.getUsers()).thenAnswer(
        (_) async => ApiResponse(success: false, code: 400, data: null));

    final response = await mockUserService.getUsers();

    expect(response.code, 400);
    expect(response.success, false);
    expect(response.data, null);
  });
}
