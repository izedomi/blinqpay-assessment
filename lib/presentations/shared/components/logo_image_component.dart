import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class LogoImageComponent extends StatelessWidget {
  final double? width;
  final double? height;
  const LogoImageComponent({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/images/svg/blinqpay.svg",
      height: width ?? h(25),
      width: height ?? w(100),
    );
  }
}
