import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserItemShimmer extends StatelessWidget {
  const UserItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primaryColor.withOpacity(0.4),
      highlightColor: Colors.grey.shade100,
      enabled: true,
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
        ],
      ),
    );
  }
}
