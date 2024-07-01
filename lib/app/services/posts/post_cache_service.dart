import 'dart:convert';

import 'package:blinqpay/app/constants/app_text.dart';
import 'package:blinqpay/app/constants/storage_keys.dart';
import 'package:blinqpay/app/services/posts/interfaces/post_service_interface.dart';
import 'package:blinqpay/app/utils/log_util.dart';
import 'package:blinqpay/app/utils/storage_util.dart';
import 'package:blinqpay/models/api_response.dart';

class PostCacheService implements PostServiceInterface {
  @override
  Future<ApiResponse> getPosts() async {
    try {
      final data = await StorageUtil.get(StorageKey.posts);
      dLog("[PostCacheService] posts from cache => $data");
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

  savePosts(String posts) async {
    await StorageUtil.save(StorageKey.posts, posts);
    dLog("[PostCacheService] posts saved to cache");
  }
}
