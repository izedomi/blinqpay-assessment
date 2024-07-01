import 'package:blinqpay/app/constants/png_image_asset.dart';
import 'package:blinqpay/presentations/screens/profile/components/engagement_summary_component.dart';
import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:blinqpay/presentations/shared/components/empty_component.dart';
import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String bio =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.";

  @override
  void initState() {
    super.initState();
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
                          "My Profile",
                          style: TextStyle(fontSize: fs(24)),
                        ),
                        SizedBox(
                          width: w(40),
                          height: h(40),
                        ),
                      ],
                    )),
                yspace(60),
                Container(
                  width: w(70),
                  height: h(70),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(PngImageAsset.profile),
                ),
                yspace(24),
                Text(
                  "Emmanuel Izedomi",
                  style:
                      TextStyle(fontSize: fs(20), fontWeight: FontWeight.w600),
                ),
                yspace(0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w(24)),
                  child: Text(
                    bio,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: fs(12)),
                  ),
                ),
                yspace(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w(24)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.location,
                          color: AppColors.primaryColor),
                      xspace(12),
                      Text(
                        "Lagos, Nigeria",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: fs(12), color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                yspace(40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w(8)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EngagementSummaryComponent(
                        engagement: "Posts",
                        summary: "0",
                      ),
                      EngagementSummaryComponent(
                          engagement: "Followers", summary: "0"),
                      EngagementSummaryComponent(
                          engagement: "Following", summary: "0")
                    ],
                  ),
                ),
                const Expanded(
                    child: EmptyComponent(
                        message:
                            "Your recent activities will display here...")),
              ],
            )),
      ),
    );
  }
}
