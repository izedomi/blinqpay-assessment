import 'dart:convert';

import 'package:blinqpay/app/constants/app_text.dart';
import 'package:blinqpay/app/enum/viewstate.dart';
import 'package:blinqpay/app/repository/interfaces/user_repository_interface.dart';
import 'package:blinqpay/app/services/users/interfaces/user_service_interface.dart';
import 'package:blinqpay/app/services/users/user_cache_service.dart';
import 'package:blinqpay/app/services/users/user_service.dart';
import 'package:blinqpay/app/utils/app_init_util.dart';
import 'package:blinqpay/app/utils/internet_connectivity_util.dart';
import 'package:blinqpay/models/api_response.dart';
import 'package:blinqpay/models/user_model.dart';
import 'package:flutter/foundation.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel(this.userRepository);

  UserRepositoryInterface userRepository;
  late ApiResponse _apiResponse;

  List<User> _users = [];
  List<User> get users => _users;

  ViewState _viewState = ViewState.idle;
  ViewState get viewState => _viewState;

  String _errMsg = "";
  String get errMsg => _errMsg;

  void setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  Future<void> getUsers(UserServiceInterface userService) async {
    try {
      if (viewState == ViewState.busy || _users.isNotEmpty) {
        return;
      }
      setViewState(ViewState.busy);

      _apiResponse = await userRepository.getUsers(userService);

      if (!_apiResponse.success) {
        _errMsg = _apiResponse.message ?? AppText.errMsg;
      }

      //save to local storage
      //await getIt<UserCacheService>().saveUsers(_apiResponse.data);

      setViewState(ViewState.completed);
      _users = userFromJson(jsonEncode(_apiResponse.data));
    } catch (e) {
      _errMsg = AppText.errMsg;
      setViewState(ViewState.error);
    }
  }

  get getService async => await ConnectivityUtil.hasInternet
      ? getIt<UserService>()
      : getIt<UserCacheService>();
}
