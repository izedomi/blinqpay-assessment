import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:blinqpay/views/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAvatarWidget extends StatelessWidget {
  final String url;
  final String initials;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? boxFit;
  const CustomAvatarWidget(
      {super.key,
      required this.url,
      required this.initials,
      this.height,
      this.width,
      this.radius,
      this.boxFit});

  @override
  Widget build(BuildContext context) {
    double w = 28.w;
    double h = 28.w;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? r(16)),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width ?? w,
        height: height ?? h,
        placeholder: (context, url) {
          return _placeHolder();
        },
        errorWidget: (context, _, url) {
          return _placeHolder();
        },
        fit: boxFit ?? BoxFit.cover,
      ),
    );
  }

  _placeHolder() {
    return Container(
      width: 28.w,
      height: 28.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.vuGrey,
        //shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(radius ?? 16.r),
      ),
      child: Text(
        initials,
        style: TextStyle(
            color: AppColors.wiBlack,
            fontWeight: FontWeight.w600,
            fontSize: fs(20)),
      ),
    );
  }
}
