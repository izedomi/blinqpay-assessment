import 'package:blinqpay/app/utils/text_util.dart';
import 'package:blinqpay/models/user_model.dart';
import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:blinqpay/presentations/shared/components/custom_avatar_widget.dart';
import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/material.dart';

class UserItemComponet extends StatelessWidget {
  final User user;
  const UserItemComponet({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      padding: EdgeInsets.symmetric(horizontal: w(8), vertical: h(2)),
      margin: EdgeInsets.symmetric(horizontal: w(0), vertical: h(8)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          r(16),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      r(16),
                    ),
                    border: Border.all(color: AppColors.vuGrey)),
                child: CustomAvatarWidget(
                    url: user.photo ?? "",
                    width: w(50),
                    height: w(50),
                    initials:
                        TextUtil.getInitialsFromFullname(user.name ?? "")),
              ),
              xspace(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name ?? ""),
                  yspace(3),
                  Text(
                    user.username != null && user.username!.isNotEmpty
                        ? user.username!
                        : "N_A",
                    style: TextStyle(
                      fontSize: fs(10),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.chevron_right)
            ],
          ),
        ],
      ),
    );
  }
}
