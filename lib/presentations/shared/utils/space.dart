import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VSpace extends StatelessWidget {
  const VSpace(this.length, {super.key});

  final double length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: length.h,
    );
  }
}

class HSpace extends StatelessWidget {
  const HSpace(this.length, {super.key});

  final double length;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: length.w,
    );
  }
}

//horizontally scaled number value
w(double value) {
  return value.w;
}

//vertically scalled number value
h(double value) {
  return value.h;
}

//scaled radius value
r(double value) {
  return value.r;
}

//scaled font size value
fs(double value) {
  return value.sp;
}

// Vertical margin

Widget yspace(double value) {
  return VSpace(value);
}

// Horizontal margin
Widget xspace(double value) {
  return HSpace(value);
}

get screenWidth => 1.sw;
get screenHeight => 1.sh;
