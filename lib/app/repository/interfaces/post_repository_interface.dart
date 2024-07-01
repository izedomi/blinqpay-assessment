import 'package:blinqpay/app/services/posts/interfaces/post_service_interface.dart';
import 'package:blinqpay/models/api_response.dart';

abstract class PostRepositoryInterface {
  Future<ApiResponse> getPosts(PostServiceInterface postService);
}
