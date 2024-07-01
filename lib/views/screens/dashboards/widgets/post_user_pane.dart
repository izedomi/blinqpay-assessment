import 'package:blinqpay/app/enum/viewstate.dart';
import 'package:blinqpay/app/utils/text_util.dart';
import 'package:blinqpay/models/user_model.dart';
import 'package:blinqpay/view_models/user_view_model.dart';
import 'package:blinqpay/views/screens/dashboards/shimmers/post_user_shimmer.dart';
import 'package:blinqpay/views/screens/users/bs/user_profile_bs.dart';
import 'package:blinqpay/views/shared/bs/bs_wrapper.dart';
import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:blinqpay/views/shared/widgets/custom_avatar_widget.dart';
import 'package:blinqpay/views/shared/widgets/error_component.dart';
import 'package:blinqpay/views/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostUserAvatar extends StatelessWidget {
  final double appBarHeight = 66.0;

  const PostUserAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return _content(context);
  }

  Widget _content(context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Consumer<UserViewModel>(builder: (context, vm, _) {
      if (vm.viewState == ViewState.busy) {
        return Container(
            margin: EdgeInsets.only(top: statusBarHeight),
            width: screenWidth,
            child: Column(
              children: [
                yspace(75),
                SizedBox(
                  height: h(90),
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: w(12)),
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    separatorBuilder: (context, index) {
                      return xspace(16);
                    },
                    itemBuilder: (context, index) {
                      return const PostUserShimmer();
                    },
                  ),
                ),
              ],
            ));
      }
      if (vm.viewState == ViewState.error) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: w(24), vertical: h(8)),
          child: ErrorComponent(
            message: vm.errMsg,
            onRetry: () async {
              vm.getUsers(await vm.getService);
            },
            topMargin: yspace(h(100)),
          ),
        );
      }
      if (vm.viewState == ViewState.completed && vm.users.isEmpty) {
        return const SizedBox();
      }
      if (vm.viewState == ViewState.completed && vm.users.isNotEmpty) {
        return Container(
            margin: EdgeInsets.only(top: statusBarHeight),
            width: screenWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                yspace(75),
                SizedBox(
                  height: h(97),
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: w(12)),
                    scrollDirection: Axis.horizontal,
                    itemCount: vm.users.length,
                    separatorBuilder: (context, index) {
                      return xspace(16);
                    },
                    itemBuilder: (context, index) {
                      User user = vm.users[index];
                      return GestureDetector(
                        onTap: () {
                          BsWrapper.bottomSheet(
                              context: context,
                              widget: UserProfileBs(
                                user: user,
                              ));
                        },
                        child: SizedBox(
                          //width: w(70),
                          height: w(60),

                          child: Column(
                            children: [
                              Container(
                                height: w(65),
                                width: w(65),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: AppColors.vuGrey)),
                                child: CustomAvatarWidget(
                                    url: user.photo ?? "",
                                    height: w(65),
                                    width: w(65),
                                    radius: r(32.5),
                                    initials: TextUtil.getInitialsFromFullname(
                                        user.username ?? "")),
                              ),
                              yspace(6),
                              Text(
                                user.username ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: fs(12),
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ));
      }
      return const SizedBox();
    });
  }
}
