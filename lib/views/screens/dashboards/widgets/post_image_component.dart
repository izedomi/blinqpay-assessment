import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:blinqpay/views/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostImageComponent extends StatelessWidget {
  final String url;
  final String initials;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? boxFit;
  const PostImageComponent(
      {super.key,
      required this.url,
      required this.initials,
      this.height,
      this.width,
      this.radius,
      this.boxFit});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 16.r),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width ?? w(28),
        height: height ?? w(28),
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
      width: width ?? w(28),
      height: height ?? w(28),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.2),
        //shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(radius ?? 16.r),
      ),
    );
  }
}
