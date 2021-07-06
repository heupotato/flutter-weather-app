library page_transition;

import 'package:flutter/material.dart';

enum PageTransitionType {
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
}

class CustomPageTransition<T> extends PageRouteBuilder<T> {
  final PageTransitionType type;
  final Widget child;
  final Duration duration;

  CustomPageTransition({
    required this.type,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    RouteSettings? settings,
  }) : super(
          settings: settings,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionDuration: duration,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              _transitionsBuilder(
            type,
            context,
            animation,
            secondaryAnimation,
            child,
          ),
        );

  static Widget _transitionsBuilder(
    PageTransitionType type,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (type) {
      case PageTransitionType.fade:
        return FadeTransition(opacity: animation, child: child);

      case PageTransitionType.rightToLeft:
        return SlideTransition(
          transformHitTests: false,
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );

      case PageTransitionType.leftToRight:
        return SlideTransition(
          transformHitTests: false,
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );

      case PageTransitionType.upToDown:
        return SlideTransition(
          transformHitTests: false,
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );

      case PageTransitionType.downToUp:
        return SlideTransition(
          transformHitTests: false,
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );

      default:
        return child;
    }
  }
}

class FadeRoute<T> extends CustomPageTransition<T> {
  FadeRoute(
    Widget child, {
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          settings: settings,
          type: PageTransitionType.fade,
          child: child,
          duration: duration,
        );
}

class RightLeftRoute<T> extends CustomPageTransition<T> {
  RightLeftRoute(
    Widget child, {
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          settings: settings,
          type: PageTransitionType.rightToLeft,
          child: child,
          duration: duration,
        );
}

class LeftRightRoute<T> extends CustomPageTransition<T> {
  LeftRightRoute(
    Widget child, {
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          settings: settings,
          type: PageTransitionType.leftToRight,
          child: child,
          duration: duration,
        );
}

class UpDownRoute<T> extends CustomPageTransition<T> {
  UpDownRoute(
    Widget child, {
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          settings: settings,
          type: PageTransitionType.upToDown,
          child: child,
          duration: duration,
        );
}

class DownUpRoute<T> extends CustomPageTransition<T> {
  DownUpRoute(
    Widget child, {
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
          settings: settings,
          type: PageTransitionType.downToUp,
          child: child,
          duration: duration,
        );
}
