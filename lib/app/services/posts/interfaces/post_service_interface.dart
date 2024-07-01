import 'package:blinqpay/models/api_response.dart';

abstract class PostServiceInterface {
  Future<ApiResponse> getPosts();
}
