import 'package:blinqpay/app/enum/viewstate.dart';
import 'package:blinqpay/app/repository/interfaces/user_repository_interface.dart';
import 'package:blinqpay/app/services/users/interfaces/user_service_interface.dart';
import 'package:blinqpay/models/api_response.dart';
import 'package:blinqpay/view_models/user_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'user_view_model_test.mocks.dart';

@GenerateMocks([UserRepositoryInterface, UserServiceInterface])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockUserRepositoryInterface mockUserRepository;
  late MockUserServiceInterface mockUserService;
  late UserViewModel userViewModel;

  setUp(() {
    mockUserRepository = MockUserRepositoryInterface();
    mockUserService = MockUserServiceInterface();
    userViewModel = UserViewModel(mockUserRepository);
  });

  group("posts", () {
    test("when instance is created, variables are initialized correctly", () {
      expect(userViewModel.users.length, 0);
      expect(userViewModel.viewState, ViewState.idle);
      expect(userViewModel.errMsg, "");
    });

    test("viewstate update is successful", () {
      userViewModel.setViewState(ViewState.completed);
      expect(userViewModel.viewState, ViewState.completed);
    });

    test("get users successfully", () async {
      final data = [
        {
          "userId": "blinq001",
          "username": "izedomi",
          "name": "Emmanuel Izedomi",
          "photo": "https://blinq.io",
          "bio": "Learing is awesome!"
        }
      ];

      when(mockUserRepository.getUsers(mockUserService)).thenAnswer(
          (_) async => ApiResponse(success: true, code: 200, data: data));

      await userViewModel.getUsers(mockUserService);

      expect(userViewModel.users.length, 1);
      expect(userViewModel.viewState, ViewState.completed);
      expect(userViewModel.users.isNotEmpty, true);
    });

    test("error fetching users", () async {
      when(mockUserRepository.getUsers(mockUserService)).thenAnswer(
          (_) async => ApiResponse(success: false, code: 400, data: dynamic));

      await userViewModel.getUsers(mockUserService);

      expect(userViewModel.users.length, 0);
      expect(userViewModel.viewState, ViewState.error);
    });
  });
}
