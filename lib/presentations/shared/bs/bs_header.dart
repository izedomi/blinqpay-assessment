// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BsHeader extends StatelessWidget {
  const BsHeader(
      {super.key,
      required this.navTitle,
      this.rightIconWidget,
      this.titleFontSize,
      this.textAlign,
      this.titleColor});

  final String navTitle;
  final Widget? rightIconWidget;
  final TextAlign? textAlign;

  final double? titleFontSize;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 10,
          child: Text(navTitle,
              maxLines: 2,
              textAlign: textAlign ?? TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // color: AppColor.brandBlack,
                  fontSize: 18.sp,
                  height: 1.2)),
        ),
        Flexible(
          flex: 2,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    //color: AppColors.white,
                    border: Border.all(width: 1.sp, color: AppColors.vuGrey)),
                child: const Icon(Icons.close)),
          ),
        )
      ],
    );
  }
}
