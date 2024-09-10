import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:news/core/providers/themes/themes_provider.dart';
import 'package:news/core/themes/app_themes.dart';
import 'package:provider/provider.dart';

class BgPattern extends StatelessWidget {
  final int animationDuration;
  final Widget child;
  final Color? patternColor;

  const BgPattern(
      {super.key,
      this.animationDuration = 0,
      required this.child,
      this.patternColor});

  @override
  Widget build(BuildContext context) {
    ThemesProvider themesProvider = Provider.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        FadeIn(
          duration: Duration(seconds: animationDuration),
          child: Image.asset(
            'assets/images/pattern.png',
            color: patternColor ??
                (themesProvider.currentThemeMode == ThemeMode.light
                    ? Colors.black
                    : themesProvider.currentThemeMode == ThemeMode.dark
                        ? AppThemes.darkOnPrimaryColor
                        : MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? Colors.black
                            : AppThemes.darkOnPrimaryColor),
            fit: BoxFit.cover,
          ),
        ),
        child
      ],
    );
  }
}
