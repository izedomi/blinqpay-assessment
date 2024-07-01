import 'package:blinqpay/app/constants/storage_keys.dart';
import 'package:blinqpay/app/repository/post_repository.dart';
import 'package:blinqpay/app/repository/user_repository.dart';
import 'package:blinqpay/app/services/posts/post_cache_service.dart';
import 'package:blinqpay/app/services/posts/post_service.dart';
import 'package:blinqpay/app/services/users/user_cache_service.dart';
import 'package:blinqpay/app/services/users/user_service.dart';
import 'package:blinqpay/app/utils/log_util.dart';
import 'package:blinqpay/app/utils/storage_util.dart';
import 'package:blinqpay/firebase_options.dart';
import 'package:blinqpay/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class AppInitializationUtil {
  initialize() async {
    await _firebaseInitialization();
    await _themeInitialization();
    _getItInitialization();
  }

  _firebaseInitialization() async {
    await Firebase.initializeApp(
        name: "Blinqpay", options: DefaultFirebaseOptions.currentPlatform);
    dLog("===> firebase initialized");
  }

  _themeInitialization() async {
    isLightMode = await StorageUtil.get(StorageKey.isLightMode) == "true";
    dLog("===> app theme initialized");
  }

  _getItInitialization() {
    getIt.registerSingleton<UserService>(UserService());
    getIt.registerSingleton<PostService>(PostService());
    getIt.registerSingleton<UserCacheService>(UserCacheService());
    getIt.registerSingleton<PostCacheService>(PostCacheService());

    getIt.registerSingleton<UserRepository>(UserRepository());
    getIt.registerSingleton<PostRepository>(PostRepository());
    dLog("===> GetIt initialized");
  }

  getItMockInitialization() {
    // getIt.registerSingleton<UserMockService>(UserMockService());
    // getIt.registerSingleton<PostMockService>(PostMockService());
    // getIt.registerSingleton<UserCacheService>(UserCacheService());
    // getIt.registerSingleton<PostCacheService>(PostCacheService());
  }
}
