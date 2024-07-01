import 'dart:async';

import 'package:blinqpay/app/routes/routes.dart';
import 'package:blinqpay/views/shared/utils/space.dart';
import 'package:blinqpay/views/shared/widgets/logo_image_component.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double logoOpacity = 0;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 3000), () async {
      context.push(SharedRoute.parent);
      return;
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        logoOpacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: AnimatedOpacity(
                opacity: logoOpacity,
                duration: const Duration(milliseconds: 1000),
                child: LogoImageComponent(height: h(150), width: w(80)))),
      ),
    );
  }
}
