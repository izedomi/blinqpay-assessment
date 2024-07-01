import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabNav {
  String name;
  Widget icon;

  double? width = 25.w;
  double? height = 25.w;
  TabNav({required this.icon, required this.name, this.width, this.height});
}
