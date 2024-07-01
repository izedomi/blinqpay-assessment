import 'package:blinqpay/app/constants/app_text.dart';
import 'package:blinqpay/app/services/posts/interfaces/post_service_interface.dart';
import 'package:blinqpay/app/utils/log_util.dart';
import 'package:blinqpay/models/api_response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostService implements PostServiceInterface {
  final FirebaseFirestore _firebaseStore = FirebaseFirestore.instance;

  CollectionReference get postsRef => _firebaseStore.collection("post");

  @override
  Future<ApiResponse> getPosts() async {
    try {
      QuerySnapshot querySnapshot = await postsRef.get();

      // Get data from docs and convert map to List
      final posts = querySnapshot.docs.map((doc) => doc.data()).toList();
      dLog(posts.length.toString());
      return ApiResponse(success: true, data: posts, code: 200);
    } catch (e, s) {
      dLog(e.toString());
      dLog(s.toString());
      return ApiResponse(success: false, code: 400, message: AppText.errMsg);
    }
  }
}
