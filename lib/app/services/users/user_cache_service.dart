import 'dart:convert';
import 'package:blinqpay/app/constants/app_text.dart';
import 'package:blinqpay/app/constants/storage_keys.dart';
import 'package:blinqpay/app/services/users/interfaces/user_service_interface.dart';
import 'package:blinqpay/app/utils/log_util.dart';
import 'package:blinqpay/app/utils/storage_util.dart';
import 'package:blinqpay/models/api_response.dart';

class UserCacheService implements UserServiceInterface {
  @override
  Future getUsers() async {
    try {
      final data = await StorageUtil.get(StorageKey.users);
      dLog("[UserCacheService] ===> users from cache => $data");
      if (data != null) {
        return ApiResponse(success: true, data: json.decode(data));
      }

      return ApiResponse(success: false, code: 400, data: AppText.errMsg);
    } catch (e, s) {
      dLog(e.toString());
      dLog(s.toString());
      return ApiResponse(success: false, code: 400, message: AppText.errMsg);
    }
  }

  saveUsers(String users) async {
    await StorageUtil.save(StorageKey.users, jsonEncode(users));
    dLog("[UserCacheService] posts saved to cache");
  }
}
