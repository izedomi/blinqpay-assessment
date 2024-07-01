import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:blinqpay/views/theme/app_color.dart';
import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final Widget? topMargin;
  const ErrorComponent(
      {super.key,
      required this.message,
      required this.onRetry,
      this.topMargin});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        topMargin ?? const SizedBox(),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fs(14), color: AppColors.vuGrey),
        ),
        yspace(8),
        InkWell(
          onTap: onRetry,
          child: Text(
            "Try Again",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: fs(14), color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
