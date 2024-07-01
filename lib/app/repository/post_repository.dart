import 'package:blinqpay/app/repository/interfaces/post_repository_interface.dart';
import 'package:blinqpay/app/services/posts/interfaces/post_service_interface.dart';
import 'package:blinqpay/models/api_response.dart';

class PostRepository implements PostRepositoryInterface {
  @override
  Future<ApiResponse> getPosts(PostServiceInterface postService) async {
    return await postService.getPosts();
  }
}
