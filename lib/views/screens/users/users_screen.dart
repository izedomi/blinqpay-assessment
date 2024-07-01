import 'package:animate_do/animate_do.dart';
import 'package:blinqpay/app/enum/viewstate.dart';
import 'package:blinqpay/models/user_model.dart';
import 'package:blinqpay/view_models/user_view_model.dart';
import 'package:blinqpay/views/screens/users/bs/user_profile_bs.dart';
import 'package:blinqpay/views/screens/users/components/user_item_component.dart';
import 'package:blinqpay/views/screens/users/shimmers/user_item_shimmer.dart';
import 'package:blinqpay/views/shared/bs/bs_wrapper.dart';
import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:blinqpay/views/shared/widgets/empty_component.dart';
import 'package:blinqpay/views/shared/widgets/error_component.dart';
import 'package:blinqpay/views/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late UserViewModel userViewModel;

  @override
  void initState() {
    super.initState();
    userViewModel = context.read<UserViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initialize();
    });
  }

  initialize() async {
    userViewModel.getUsers(await userViewModel.getService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 60.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: w(40),
                          height: h(40),
                        ),
                        Text(
                          "Blinqers",
                          style: TextStyle(fontSize: fs(22)),
                        ),
                        SizedBox(
                          width: w(40),
                          height: h(40),
                        ),
                      ],
                    )),
                Expanded(
                    child: Consumer<UserViewModel>(builder: (context, vm, _) {
                  if (vm.viewState == ViewState.busy) {
                    return ListView.separated(
                        padding: EdgeInsets.only(top: h(12), bottom: h(12)),
                        itemCount: 10,
                        separatorBuilder: (context, index) {
                          return Column(
                            children: [
                              yspace(8),
                              Divider(
                                color: AppColors.vuGrey.withOpacity(0.6),
                              ),
                              yspace(8),
                            ],
                          );
                        },
                        itemBuilder: (conttext, index) {
                          return const UserItemShimmer();
                        });
                  }
                  if (vm.viewState == ViewState.error) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(24)),
                      child: ErrorComponent(
                        message: vm.errMsg,
                        topMargin: yspace(130),
                        onRetry: () {
                          vm.getUsers(vm.getService);
                        },
                      ),
                    );
                  }
                  if (vm.viewState == ViewState.completed && vm.users.isEmpty) {
                    return const EmptyComponent(message: "No blinqers yet...");
                  }

                  return FadeInUp(
                    child: ListView.separated(
                        itemCount: vm.users.length,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: AppColors.vuGrey.withOpacity(0.6),
                          );
                        },
                        itemBuilder: (conttext, index) {
                          User user = vm.users[index];
                          return GestureDetector(
                              onTap: () {
                                BsWrapper.bottomSheet(
                                    context: context,
                                    widget: UserProfileBs(
                                      user: user,
                                    ));
                              },
                              child: UserItemComponet(user: user));
                        }),
                  );
                })),
              ],
            )),
      ),
    );
  }
}
