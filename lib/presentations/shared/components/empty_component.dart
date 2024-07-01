import 'package:blinqpay/app/constants/png_image_asset.dart';
import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/material.dart';

class EmptyComponent extends StatelessWidget {
  final String message;
  final Widget? topMargin;
  const EmptyComponent({super.key, required this.message, this.topMargin});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        topMargin ?? const SizedBox(),
        Image.asset(PngImageAsset.empty,
            width: w(120), height: w(120), fit: BoxFit.contain),
        yspace(24),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fs(14), color: AppColors.primaryColor),
        ),
      ],
    );
  }
}
