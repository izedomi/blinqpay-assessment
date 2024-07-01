import 'package:blinqpay/app/enum/viewstate.dart';
import 'package:blinqpay/app/services/posts/post_cache_service.dart';
import 'package:blinqpay/app/services/users/user_cache_service.dart';
import 'package:blinqpay/app/utils/app_init_util.dart';
import 'package:blinqpay/models/post_model.dart';
import 'package:blinqpay/models/user_model.dart';
import 'package:blinqpay/view_models/post_view_model.dart';
import 'package:blinqpay/view_models/user_view_model.dart';
import 'package:blinqpay/views/screens/dashboards/widgets/post_appbar.dart';
import 'package:blinqpay/views/screens/dashboards/widgets/post_component.dart';
import 'package:blinqpay/views/screens/dashboards/widgets/post_user_pane.dart';
import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:blinqpay/views/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  late UserViewModel userViewModel;
  late PostViewModel postViewModel;
  String defaultUserId = "100";

  @override
  void initState() {
    super.initState();
    userViewModel = context.read<UserViewModel>();
    postViewModel = context.read<PostViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  _initialize() {
    _getUsers();
    _getPosts();
  }

  _getUsers() async {
    await userViewModel.getUsers(await userViewModel.getService);
    if (userViewModel.users.isNotEmpty) {
      await getIt<UserCacheService>()
          .saveUsers(userToJson(userViewModel.users));
    }
  }

  _getPosts() async {
    await postViewModel.getPosts(await postViewModel.getService);
    if (postViewModel.posts.isNotEmpty) {
      await getIt<PostCacheService>()
          .savePosts(postToJson(postViewModel.posts));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            _initialize();
          },
          child: CustomScrollView(
            slivers: [
              Consumer<UserViewModel>(builder: (context, vm, _) {
                return SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  title: const PostAppBar(),
                  expandedHeight:
                      h(vm.viewState == ViewState.error ? 130 : 180),
                  collapsedHeight: h(65),
                  flexibleSpace: const FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      background: PostUserAvatar()),
                );
              }),
              const PostsComponent(),
            ],
          )),
    );
  }
}
