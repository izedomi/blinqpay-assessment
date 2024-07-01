import 'dart:convert';
import 'package:blinqpay/app/constants/app_text.dart';
import 'package:blinqpay/app/enum/viewstate.dart';
import 'package:blinqpay/app/repository/interfaces/post_repository_interface.dart';
import 'package:blinqpay/app/services/posts/interfaces/post_service_interface.dart';
import 'package:blinqpay/app/services/posts/post_cache_service.dart';
import 'package:blinqpay/app/services/posts/post_service.dart';
import 'package:blinqpay/app/utils/app_init_util.dart';
import 'package:blinqpay/app/utils/internet_connectivity_util.dart';
import 'package:blinqpay/app/utils/log_util.dart';
import 'package:blinqpay/models/api_response.dart';
import 'package:blinqpay/models/post_model.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class PostViewModel extends ChangeNotifier {
  PostRepositoryInterface postRepository;

  PostViewModel(this.postRepository);
  late ApiResponse _apiResponse;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  Post? _visiblePost;
  Post? get visiblePost => _visiblePost;
  setVisiblePost(post) {
    _visiblePost = post;
  }

  ViewState _viewState = ViewState.idle;
  ViewState get viewState => _viewState;

  String _errMsg = "";
  String get errMsg => _errMsg;

  void setViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  setPost(List<Post> p) {
    _posts = p;
  }

  Future<void> getPosts(PostServiceInterface postService,
      {notifyUI = true}) async {
    try {
      if (notifyUI) {
        setViewState(ViewState.busy);
      }

      _apiResponse = await postRepository.getPosts(postService);

      dLog(_apiResponse.data.toString());

      if (!_apiResponse.success) {
        _errMsg = _apiResponse.message ?? AppText.errMsg;
        setViewState(ViewState.error);
        return;
      }

      //save to local storage
      // if (!isTest) {
      //   await getIt<PostCacheService>().savePosts(_apiResponse.data);
      // }

      setViewState(ViewState.completed);
      _posts = postFromJson(jsonEncode(_apiResponse.data));
    } catch (e, s) {
      dLog(e.toString());
      dLog(s.toString());
      _errMsg = AppText.errMsg;
      setViewState(ViewState.error);
    }
  }

  isVideoContent(Post post) => post.noMedia == false && post.video == true;

  isImageContent(Post post) => post.noMedia == false && post.video == false;

  isTextContent(Post post) => post.noMedia == true;

  contentHasDescription(Post post) =>
      post.description != null && post.description!.isNotEmpty;

  likeAndUnlike(int postIndex, String userId) {
    if (!_postIndexIsValid(postIndex)) return;
    final post = posts[postIndex];

    //update likes list
    _updateLikesAttribute(post, userId);

    //update likes count
    _updateLikesCount(post, userId);

    notifyListeners();
  }

  _postIndexIsValid(index) => index < posts.length && index > -1;

  _updateLikesAttribute(Post post, String userId) {
    post.likes.contains(userId)
        ? post.likes.remove(userId)
        : post.likes.add(userId);
  }

  _updateLikesCount(Post post, String userId) {
    post.likeCount = post.likes.contains(userId)
        ? (post.likeCount ?? 0) + 1
        : (post.likeCount ?? 0) - 1;
  }

  postIsLikedByUser(Post post, String userId) {
    return post.likes.contains(userId);
  }

  get getService async => await ConnectivityUtil.hasInternet
      ? getIt<PostService>()
      : getIt<PostCacheService>();

  syncData() async {
    await getPosts(await getService, notifyUI: false);
  }

  postWidgetIsVisible(Post post, double minViewport) {
    return isVideoContent(post) &&
        (post.viewFraction ?? 0) >= minViewport &&
        post.controller != null;
  }
}
