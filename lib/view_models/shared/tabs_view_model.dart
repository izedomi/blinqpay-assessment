import 'package:blinqpay/app/constants/png_image_asset.dart';
import 'package:blinqpay/views/screens/dashboards/post_screen.dart';
import 'package:blinqpay/views/screens/profile/profile_screen.dart';
import 'package:blinqpay/views/screens/users/users_screen.dart';
import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../models/shared/tab_nav.dart';

class TabsViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  List<TabNav> bottomNav = [
    TabNav(
        icon: const Icon(Iconsax.menu),
        name: 'Posts',
        width: 25.w,
        height: 25.w),
    TabNav(
        icon: Padding(
          padding: EdgeInsets.only(top: h(1)),
          child: const Icon(Iconsax.user),
        ),
        name: 'Blinqers',
        width: 25.w,
        height: 25.w),
    TabNav(
        icon: Image.asset(PngImageAsset.profile, width: 25.w, height: 25.w),
        name: 'Profile',
        width: 25.w,
        height: 25.w),
  ];
  List screens = [
    const PostScreen(),
    const UsersScreen(),
    const ProfileScreen()
  ];

  updateIndex(int i) {
    _currentIndex = i;

    notifyListeners();
  }
}
