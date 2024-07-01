import 'package:blinqpay/presentations/shared/utils/space.dart';
import 'package:blinqpay/presentations/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class NoInternetComponent extends StatelessWidget {
  const NoInternetComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Provider.of<InternetConnectionStatus>(context) ==
          InternetConnectionStatus.disconnected,
      child: Column(
        children: [
          yspace(100),
          Container(
            width: screenWidth,
            height: h(40),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: w(16),
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(r(8)),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Iconsax.information,
                  color: AppColors.white,
                ),
                xspace(8),
                Text(
                  "You are offline. Some functionality maybe unavailable.",
                  style: TextStyle(fontSize: fs(10), color: AppColors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
