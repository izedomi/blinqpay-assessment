import 'package:blinqpay/app/constants/png_image_asset.dart';
import 'package:blinqpay/app/constants/storage_keys.dart';
import 'package:blinqpay/app/utils/storage_util.dart';
import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:blinqpay/views/shared/widgets/logo_image_component.dart';
import 'package:blinqpay/views/theme/app_color.dart';
import 'package:blinqpay/views/theme/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class PostAppBar extends StatelessWidget {
  const PostAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: w(45),
            height: h(45),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(PngImageAsset.profile),
          ),
          const LogoImageComponent(),
          InkWell(
            onTap: () {
              final vm = context.read<ThemeSelector>();
              vm.setTheme(vm.isLightMode ? ThemeMode.dark : ThemeMode.light);
              StorageUtil.save(
                  StorageKey.isLightMode, vm.isLightMode ? "true" : "false");
            },
            child: SizedBox(
              width: w(40),
              height: h(40),
              child: const Icon(
                Iconsax.setting_2,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
