import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LightStatusBarScreen extends StatelessWidget {
  final Widget child;

  const LightStatusBarScreen({required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: child,
    );
  }
}

class DarkStatusBarScreen extends StatelessWidget {
  final Widget child;

  const DarkStatusBarScreen({required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: child,
    );
  }
}

class CustomStatusBarScreen extends StatelessWidget {
  final Widget child;
  final SystemUiOverlayStyle? style;
  final Color? navigationBarColor;
  final Color? navigationBarDividerColor;
  final Brightness? navigationBarIconBrightness;
  final Color? statusBarColor;
  final Brightness? statusBarBrightness;
  final Brightness? statusBarIconBrightness;

  const CustomStatusBarScreen({
    required this.child,
    this.style,
    this.navigationBarColor,
    this.navigationBarDividerColor,
    this.navigationBarIconBrightness,
    this.statusBarColor,
    this.statusBarBrightness,
    this.statusBarIconBrightness,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: (style != null)
          ? style!
          : SystemUiOverlayStyle(
              systemNavigationBarColor: navigationBarColor,
              systemNavigationBarDividerColor: navigationBarDividerColor,
              systemNavigationBarIconBrightness: navigationBarIconBrightness,
              statusBarColor: statusBarColor,
              statusBarBrightness: statusBarBrightness,
              statusBarIconBrightness: statusBarIconBrightness,
            ),
      child: child,
    );
  }
}
