import 'package:animate_do/animate_do.dart';
import 'package:blinqpay/app/enum/viewstate.dart';
import 'package:blinqpay/app/utils/date_utils.dart';
import 'package:blinqpay/app/utils/log_util.dart';
import 'package:blinqpay/models/post_model.dart';
import 'package:blinqpay/view_models/post_view_model.dart';
import 'package:blinqpay/views/screens/dashboards/shimmers/post_item_shimmer.dart';
import 'package:blinqpay/views/screens/dashboards/widgets/post_engagement_likes.dart';
import 'package:blinqpay/views/screens/dashboards/widgets/post_image_component.dart';
import 'package:blinqpay/views/screens/dashboards/widgets/post_text_component.dart';
import 'package:blinqpay/views/screens/dashboards/widgets/post_video_component.dart';
import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:blinqpay/views/shared/widgets/empty_component.dart';
import 'package:blinqpay/views/shared/widgets/error_component.dart';
import 'package:blinqpay/views/theme/app_color.dart';
import 'package:blinqpay/views/theme/theme_selector.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PostsComponent extends StatefulWidget {
  const PostsComponent({super.key});

  @override
  State<PostsComponent> createState() => _PostsComponentState();
}

class _PostsComponentState extends State<PostsComponent> {
  String defaultUserId = "100";

  @override
  Widget build(BuildContext context) {
    return Consumer<PostViewModel>(builder: (context, vm, _) {
      if (vm.viewState == ViewState.busy) {
        return SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 10,
          (context, index) => const PostItemShimmer(),
        ));
      }
      if (vm.viewState == ViewState.error) {
        return SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 1,
          (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: w(24)),
              child: ErrorComponent(
                message: vm.errMsg,
                topMargin: yspace(130),
                onRetry: () async {
                  vm.getPosts(await vm.getService);
                },
              )),
        ));
      }
      if (vm.viewState == ViewState.completed && vm.posts.isEmpty) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) =>
                  const EmptyComponent(message: "No posts yet...")),
        );
      }
      if (vm.viewState == ViewState.completed && vm.posts.isNotEmpty) {
        return SliverList(
            delegate: SliverChildBuilderDelegate(childCount: vm.posts.length,
                (context, index) {
          Post post = vm.posts[index];

          return VisibilityDetector(
            key: ObjectKey(index.toString()),
            onVisibilityChanged: (visibility) {
              post.viewFraction = visibility.visibleFraction;
              double minViewFraction = 0.8;
              if (vm.postWidgetIsVisible(post, minViewFraction)) {
                dLog("post $index ==> Widget is in focus");
                post.controller?.play();
                post.controller?.setLooping(true);
              }
              if (!vm.postWidgetIsVisible(post, minViewFraction)) {
                dLog("post $index ==> Widget not in focus");
                post.controller?.setLooping(false);
                post.controller?.pause();
              }
            },
            child: FadeInRight(
              //  delay: const Duration(milliseconds: 1000),
              child: Container(
                width: screenWidth,
                padding:
                    EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
                margin:
                    EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
                decoration: BoxDecoration(
                  color: context.watch<ThemeSelector>().isLightMode
                      ? AppColors.white
                      : AppColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(r(16)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        RandomAvatar(
                          post.username ?? "",
                          trBackground: false,
                          width: w(40),
                          height: h(40),
                        ),
                        xspace(8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.username ?? ""),
                            yspace(2),
                            Text(
                              DateUtil.timeAgo(
                                post.timestamp ?? 0,
                              ),
                              style: TextStyle(
                                fontSize: fs(10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (vm.contentHasDescription(post) ||
                        vm.isTextContent(post))
                      Column(
                        children: [
                          yspace(8),
                          GestureDetector(
                            onDoubleTap: () {
                              vm.likeAndUnlike(index, defaultUserId);
                            },
                            child: PostTextComponent(
                                description: post.description ?? ""),
                          ),
                        ],
                      ),
                    if (vm.isImageContent(post))
                      Column(
                        children: [
                          yspace(16),
                          GestureDetector(
                            onDoubleTap: () {
                              vm.likeAndUnlike(index, defaultUserId);
                            },
                            child: PostImageComponent(
                              url: post.thumbnail ?? "",
                              initials: "",
                              width: double.infinity,
                              height: h(300),
                            ),
                          ),
                        ],
                      ),
                    if (vm.isVideoContent(post))
                      Column(
                        children: [
                          yspace(16),
                          GestureDetector(
                            onDoubleTap: () {
                              vm.likeAndUnlike(index, defaultUserId);
                            },
                            child: GestureDetector(
                              onDoubleTap: () {
                                vm.likeAndUnlike(index, defaultUserId);
                              },
                              child: PostVideoComponent(
                                id: post.id?.toString() ?? "",
                                url: post.link ?? "",
                                initials: "",
                                width: double.infinity,
                                height: h(300),
                                play: (isMounted,
                                    CachedVideoPlayerController? controller) {
                                  dLog(
                                      "component created: ${post.viewFraction} ");
                                  post.controller = controller;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    Column(
                      children: [
                        yspace(16),
                        Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: vm.postIsLikedByUser(post, defaultUserId)
                                  ? w(70)
                                  : w(65),
                              height: h(40),
                              decoration: BoxDecoration(
                                  color:
                                      vm.postIsLikedByUser(post, defaultUserId)
                                          ? Colors.deepOrange
                                          : AppColors.vuGrey,
                                  borderRadius: BorderRadius.circular(r(24))),
                              child: FadeInLeft(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      size: fs(24),
                                      color: vm.postIsLikedByUser(
                                              post, defaultUserId)
                                          ? AppColors.white
                                          : AppColors.black,
                                    ),
                                    xspace(3),
                                    Text(post.likeCount.toString(),
                                        style: TextStyle(
                                          color: vm.postIsLikedByUser(
                                                  post, defaultUserId)
                                              ? AppColors.white
                                              : AppColors.black,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            xspace(36),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Iconsax.message,
                                  size: fs(24),
                                  color: AppColors.primaryColor,
                                ),
                                xspace(3),
                                Text(post.commentCount.toString()),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    PostEngagementLikes(
                        post: post,
                        isLikedByCurrentUser:
                            vm.postIsLikedByUser(post, defaultUserId))
                  ],
                ),
              ),
            ),
          );
        }));
      }
      return SliverList(
          delegate: SliverChildBuilderDelegate(
        childCount: 1,
        (context, index) => const SizedBox(),
      ));
    });
  }
}
