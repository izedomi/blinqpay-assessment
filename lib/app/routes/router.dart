import 'package:blinqpay/app/routes/routes.dart';
import 'package:blinqpay/presentations/screens/shared/parent_screen.dart';
import 'package:blinqpay/presentations/screens/shared/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: WelcomeRoute.splash,
    routes: [
      //Welcome Route
      GoRoute(
        path: WelcomeRoute.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: SharedRoute.parent,
        builder: (context, state) => const ParentScreen(),
      ),
    ],
  );

  get router => _router;

  static MaterialPageRoute errorScreen(String msg) {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text(msg),
              ),
            ));
  }
}
