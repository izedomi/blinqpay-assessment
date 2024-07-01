import 'package:blinqpay/app/enum/viewstate.dart';
import 'package:blinqpay/app/repository/interfaces/post_repository_interface.dart';
import 'package:blinqpay/app/services/posts/interfaces/post_service_interface.dart';
import 'package:blinqpay/models/api_response.dart';
import 'package:blinqpay/models/post_model.dart';
import 'package:blinqpay/view_models/post_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_view_model_test.mocks.dart';

@GenerateMocks([PostRepositoryInterface, PostServiceInterface])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockPostRepositoryInterface mockPostRepository;
  late MockPostServiceInterface mockPostService;
  late PostViewModel postViewModel;

  setUp(() {
    mockPostRepository = MockPostRepositoryInterface();
    mockPostService = MockPostServiceInterface();
    postViewModel = PostViewModel(mockPostRepository);
  });

  group("posts", () {
    test("when instance is created, variables are initialized correctly", () {
      expect(postViewModel.posts.length, 0);
      expect(postViewModel.viewState, ViewState.idle);
      expect(postViewModel.errMsg, "");
    });

    test("viewstate update is successful", () {
      postViewModel.setViewState(ViewState.completed);
      expect(postViewModel.viewState, ViewState.completed);
    });

    test("viewstate update is successful", () {
      postViewModel.setViewState(ViewState.completed);
      expect(postViewModel.viewState, ViewState.completed);
    });

    test("post is video content", () {
      final post = Post(
          thumbnail: "",
          userId: "blinq001",
          id: "1",
          noMedia: false,
          link: "Link to media",
          username: "Izedomi",
          description: "Thi is a post test",
          timestamp: 1323232323,
          video: true,
          likes: [],
          likeCount: 12,
          commentCount: 30);

      expect(postViewModel.isVideoContent(post), true);
    });

    test("post is image content", () {
      final post = Post(
          thumbnail: "",
          userId: "blinq001",
          id: "1",
          noMedia: false,
          link: "Link to media",
          username: "Izedomi",
          description: "Thi is a post test",
          timestamp: 1323232323,
          video: false,
          likes: [],
          likeCount: 12,
          commentCount: 30);

      expect(postViewModel.isImageContent(post), true);
    });

    test("post is text content", () {
      final post = Post(
          thumbnail: "",
          userId: "blinq001",
          id: "1",
          noMedia: true,
          link: "Link to media",
          username: "Izedomi",
          description: "Thi is a post test",
          timestamp: 1323232323,
          video: false,
          likes: [],
          likeCount: 12,
          commentCount: 30);

      expect(postViewModel.isTextContent(post), true);
    });

    test("post has description", () {
      final post = Post(
          thumbnail: "",
          userId: "blinq001",
          id: "1",
          noMedia: true,
          link: "Link to media",
          username: "Izedomi",
          description: "Thi is a post test",
          timestamp: 1323232323,
          video: false,
          likes: [],
          likeCount: 12,
          commentCount: 30);

      expect(postViewModel.contentHasDescription(post), true);
    });

    test("description is empty, post has no description", () {
      final post = Post(
          thumbnail: "",
          userId: "blinq001",
          id: "1",
          noMedia: true,
          link: "Link to media",
          username: "Izedomi",
          description: "",
          timestamp: 1323232323,
          video: false,
          likes: [],
          likeCount: 12,
          commentCount: 30);

      expect(postViewModel.contentHasDescription(post), false);
    });

    test("description is null, post has no description", () {
      final post = Post(
          thumbnail: "",
          userId: "blinq001",
          id: "1",
          noMedia: true,
          link: "Link to media",
          username: "Izedomi",
          description: null,
          timestamp: 1323232323,
          video: false,
          likes: [],
          likeCount: 12,
          commentCount: 30);

      expect(postViewModel.contentHasDescription(post), false);
    });

    test("when the 'likes' property contains current user Id, user liked post",
        () {
      String userId = "100";
      final post = Post(
          thumbnail: "",
          userId: "blinq001",
          id: "1",
          noMedia: true,
          link: "Link to media",
          username: "Izedomi",
          description: null,
          timestamp: 1323232323,
          video: false,
          likes: [userId],
          likeCount: 12,
          commentCount: 30);
      expect(postViewModel.postIsLikedByUser(post, userId), true);
    });
    test(
        "when the 'likes' property does not contain current user Id, user is yet to post",
        () {
      String userId = "100";
      final post = Post(
          thumbnail: "",
          userId: "blinq001",
          id: "1",
          noMedia: true,
          link: "Link to media",
          username: "Izedomi",
          description: null,
          timestamp: 1323232323,
          video: false,
          likes: [],
          likeCount: 12,
          commentCount: 30);
      expect(postViewModel.postIsLikedByUser(post, userId), false);
    });

    test("when user likes a post, count of post likes is increased by 1", () {
      String userId = "100";
      int index = 0;
      final posts = [
        Post(
            thumbnail: "",
            userId: "blinq001",
            id: "1",
            noMedia: true,
            link: "Link to media",
            username: "Izedomi",
            description: null,
            timestamp: 1323232323,
            video: false,
            likes: [],
            likeCount: 12,
            commentCount: 30),
      ];

      postViewModel.setPost(posts);
      postViewModel.likeAndUnlike(index, userId);

      final post = postViewModel.posts[index];
      expect(post.likeCount, 13);
      expect(post.likes.contains(userId), true);
      expect(post.likes.length, 1);
    });
    test(
        "user attempts to like a post with invalid post index, post like is unchanged",
        () {
      String userId = "100";
      int index = 1;
      final posts = [
        Post(
            thumbnail: "",
            userId: "blinq001",
            id: "1",
            noMedia: true,
            link: "Link to media",
            username: "Izedomi",
            description: null,
            timestamp: 1323232323,
            video: false,
            likes: [],
            likeCount: 12,
            commentCount: 30),
      ];

      postViewModel.setPost(posts);
      postViewModel.likeAndUnlike(index, userId);

      final post = postViewModel.posts[0];
      expect(post.likeCount, 12);
      expect(post.likes.contains(userId), false);
      expect(post.likes.length, 0);
    });
    test("post is updated successfully", () {
      final posts = [
        Post(
            thumbnail: "",
            userId: "blinq001",
            id: "1",
            noMedia: true,
            link: "Link to media",
            username: "Izedomi",
            description: null,
            timestamp: 1323232323,
            video: false,
            likes: [],
            likeCount: 12,
            commentCount: 30),
      ];

      postViewModel.setPost(posts);

      expect(posts, postViewModel.posts);
    });

    test("posts is fetched successfully", () async {
      final data = [
        {
          "thumbnail": "https://firebasestorage",
          "userId": "JfpBYheu4zLhNMv539OR",
          "id": "2",
          "no_media": false,
          "link": "https://fire",
          "username": "Alex",
          "description": "Lorem ipsum dolor sit amet",
          "timestamp": 1653513552,
          "video": false
        }
      ];

      when(mockPostRepository.getPosts(mockPostService)).thenAnswer(
          (_) async => ApiResponse(success: true, code: 200, data: data));

      await postViewModel.getPosts(mockPostService);

      expect(postViewModel.posts.length, 1);
      expect(postViewModel.viewState, ViewState.completed);
      expect(postViewModel.posts.isNotEmpty, true);
    });

    test("error fetching posts", () async {
      when(mockPostRepository.getPosts(mockPostService)).thenAnswer(
          (_) async => ApiResponse(success: false, code: 400, data: dynamic));

      await postViewModel.getPosts(mockPostService);

      expect(postViewModel.posts.length, 0);
      expect(postViewModel.viewState, ViewState.error);
    });
  });
}
