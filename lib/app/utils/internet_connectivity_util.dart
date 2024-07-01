import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityUtil {
  static get hasInternet async =>
      await InternetConnectionChecker().hasConnection;
}
