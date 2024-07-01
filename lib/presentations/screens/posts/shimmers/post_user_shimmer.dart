import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostUserShimmer extends StatelessWidget {
  const PostUserShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primaryColor.withOpacity(0.4),
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: w(65),
        height: w(65),
        decoration:
            const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      ),
    );
  }
}
