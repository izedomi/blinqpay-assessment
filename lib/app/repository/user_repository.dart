import 'package:blinqpay/app/repository/interfaces/user_repository_interface.dart';
import 'package:blinqpay/app/services/users/interfaces/user_service_interface.dart';
import 'package:blinqpay/models/api_response.dart';

class UserRepository implements UserRepositoryInterface {
  @override
  Future<ApiResponse> getUsers(UserServiceInterface userService) async {
    return await userService.getUsers();
  }
}
