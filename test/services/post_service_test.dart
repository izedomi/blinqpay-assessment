import 'package:blinqpay/models/api_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../view_models/post_view_model_test.mocks.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockPostServiceInterface mockPostService;

  setUp(() {
    mockPostService = MockPostServiceInterface();
  });

  group("post service", () {
    test("posts is fetch successfully", () async {
      final data = [
        {
          "thumbnail": "https://firebasestorage",
          "userId": "JfpBYheu4zLhNMv539OR",
          "id": "2",
          "no_media": false,
          "link": "https://fire",
          "username": "Alex",
          "description": "Lorem ipsum dolor sit amet",
          "timestamp": 1653513552,
          "video": false
        }
      ];
      when(mockPostService.getPosts()).thenAnswer(
          (_) async => ApiResponse(success: true, code: 200, data: data));

      final response = await mockPostService.getPosts();

      expect(response.code, 200);
      expect(response.success, true);
      expect(response.data, data);
    });
  });

  test("error fetching posts", () async {
    when(mockPostService.getPosts()).thenAnswer(
        (_) async => ApiResponse(success: false, code: 400, data: null));

    final response = await mockPostService.getPosts();

    expect(response.code, 400);
    expect(response.success, false);
    expect(response.data, null);
  });
}
