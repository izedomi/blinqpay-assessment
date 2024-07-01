import 'package:blinqpay/app/utils/text_util.dart';
import 'package:blinqpay/models/user_model.dart';
import 'package:blinqpay/views/shared/bs/bs_header.dart';
import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:blinqpay/views/shared/widgets/custom_avatar_widget.dart';
import 'package:blinqpay/views/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserProfileBs extends StatelessWidget {
  final User user;
  const UserProfileBs({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 16.h, bottom: 56.h, left: 24.w, right: 24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BsHeader(navTitle: "Profile"),
          yspace(36.h),
          mainContent()
        ],
      ),
    );
  }

  Widget mainContent() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        height: w(65),
        width: w(65),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.vuGrey)),
        child: CustomAvatarWidget(
            url: user.photo ?? "",
            height: w(65),
            width: w(65),
            radius: r(32.5),
            initials: TextUtil.getInitialsFromFullname(user.username ?? "")),
      ),
      yspace(12),
      Text(
        user.username ?? "",
        style: TextStyle(fontSize: fs(12), fontWeight: FontWeight.w600),
      ),
      yspace(0),
      Text(
        user.name ?? "",
        style: TextStyle(fontSize: fs(20), fontWeight: FontWeight.w600),
      ),
      yspace(24),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: w(24)),
        child: Text(
          user.bio ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fs(12)),
        ),
      ),
      yspace(24),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: w(24)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.location, color: AppColors.primaryColor),
            xspace(12),
            Text(
              "Alberden, Canada",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fs(12), color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
      yspace(24),
    ]);
  }
}
