import 'package:blinqpay/app/constants/app_text.dart';
import 'package:blinqpay/app/routes/router.dart';
import 'package:blinqpay/app/utils/app_init_util.dart';
import 'package:blinqpay/base_screen.dart';
import 'package:blinqpay/locator.dart';
import 'package:blinqpay/views/theme/dark_theme.dart';
import 'package:blinqpay/views/theme/light_theme.dart';
import 'package:blinqpay/views/theme/theme_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

late bool isLightMode;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializationUtil().initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) =>
            ThemeSelector(isLightMode ? ThemeMode.light : ThemeMode.dark),
        child: Consumer<ThemeSelector>(builder: (context, selector, _) {
          return ScreenUtilInit(
            designSize: const Size(393, 845.33),
            builder: (context, child) {
              return StreamProvider<InternetConnectionStatus>(
                  initialData: InternetConnectionStatus.connected,
                  create: (_) {
                    return InternetConnectionChecker().onStatusChange;
                  },
                  child: MultiProvider(
                    providers: allProviders,
                    child: MaterialApp.router(
                      title: AppText.appName,
                      builder: (context, child) {
                        final MediaQueryData data = MediaQuery.of(context);
                        return MediaQuery(
                            data: data.copyWith(
                                textScaler: const TextScaler.linear(1)),
                            child: BaseScreen(
                              child: child!,
                            ));
                      },
                      debugShowCheckedModeBanner: false,
                      theme: lightTheme,
                      darkTheme: darkTheme,
                      themeMode: selector.mode,
                      routeInformationParser:
                          AppRouter().router.routeInformationParser,
                      routeInformationProvider:
                          AppRouter().router.routeInformationProvider,
                      routerDelegate: AppRouter().router.routerDelegate,
                    ),
                  ));
            },
          );
        }));
  }
}
