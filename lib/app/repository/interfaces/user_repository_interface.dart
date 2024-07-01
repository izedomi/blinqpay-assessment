import 'package:blinqpay/app/services/users/interfaces/user_service_interface.dart';
import 'package:blinqpay/models/api_response.dart';

abstract class UserRepositoryInterface {
  Future<ApiResponse> getUsers(UserServiceInterface userService);
}
