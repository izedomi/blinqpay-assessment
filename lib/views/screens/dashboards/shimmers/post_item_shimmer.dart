import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:blinqpay/views/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostItemShimmer extends StatelessWidget {
  const PostItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primaryColor.withOpacity(0.4),
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: screenWidth,
        padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
        margin: EdgeInsets.symmetric(horizontal: w(16), vertical: h(16)),
        decoration: BoxDecoration(
          // color: context.watch<ThemeSelector>().mode == ThemeMode.light
          //     ? AppColors.white
          //     : AppColors.white.withOpacity(0.2),
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
                Container(
                  width: w(40),
                  height: h(40),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
                xspace(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w(80),
                      height: h(10),
                      color: AppColors.white,
                    ),
                    yspace(4),
                    Container(
                      width: w(120),
                      height: h(10),
                      color: AppColors.white,
                    ),
                  ],
                ),
              ],
            ),
            yspace(12),
            Container(
              width: double.infinity,
              height: h(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(r(8)),
                color: AppColors.white,
              ),
            ),
            yspace(8),
            Container(
              width: double.infinity,
              height: h(140),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(r(12)),
                color: AppColors.white,
              ),
            ),
            Column(
              children: [
                yspace(16),
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: w(65),
                      height: h(40),
                      decoration: BoxDecoration(
                          color: AppColors.vuGrey,
                          borderRadius: BorderRadius.circular(r(24))),
                    ),
                    xspace(30),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: w(40),
                      height: h(40),
                      decoration: BoxDecoration(
                          color: AppColors.vuGrey,
                          borderRadius: BorderRadius.circular(r(24))),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
