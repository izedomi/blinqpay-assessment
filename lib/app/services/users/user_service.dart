import 'package:blinqpay/app/constants/app_text.dart';
import 'package:blinqpay/app/services/users/interfaces/user_service_interface.dart';
import 'package:blinqpay/app/utils/log_util.dart';
import 'package:blinqpay/models/api_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService implements UserServiceInterface {
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  CollectionReference get usersRef => _firebaseStore.collection("users");

  @override
  Future<ApiResponse> getUsers() async {
    try {
      QuerySnapshot querySnapshot = await usersRef.get();

      // Get data from docs and convert map to List
      final users = querySnapshot.docs.map((doc) => doc.data()).toList();
      dLog(users.toString());
      dLog(users.length.toString());
      return ApiResponse(success: true, data: users);
    } catch (e, s) {
      dLog(e.toString());
      dLog(s.toString());
      return ApiResponse(success: false, code: 400, message: AppText.errMsg);
    }
  }
}
