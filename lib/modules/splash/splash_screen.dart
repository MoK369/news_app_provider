import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:news/core/themes/app_themes.dart';
import 'package:news/core/widgets/background_pattern/background_pattern.dart';
import 'package:news/modules/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routName = "SplashScreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 4),
      () {
        if (!mounted) return;
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? AppThemes.darkPrimaryColor
          : AppThemes.lightPrimaryColor,
      child: BgPattern(
        patternColor:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? AppThemes.darkOnPrimaryColor
                : Colors.black,
        animationDuration: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 2),
            ZoomIn(
                duration: const Duration(seconds: 4),
                child: Image.asset(
                  "assets/images/news_app_logo_android12.png",
                  scale: 1.7,
                )),
            const Spacer(),
            ZoomIn(
                duration: const Duration(seconds: 4),
                child: Image.asset(
                  "assets/images/branding_android12.png",
                  scale: 2,
                )),
          ],
        ),
      ),
    );
  }
}
