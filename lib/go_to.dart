/// A simple and advanced navigation package for Flutter applications.

export 'src/go_to_extension.dart';
export 'src/go_to_navigator.dart';

import 'package:flutter/material.dart';

/// Main class for GO_TO navigation package
class GoTo {
  /// Navigate to a new screen
  ///
  /// Example:
  /// ```dart
  /// GoTo.screen(context, MyScreen());
  /// ```
  static Future<void> screen(BuildContext context, Widget screen,
      {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    } else {
      return Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }

  /// Navigate to a named route
  ///
  /// Example:
  /// ```dart
  /// GoTo.named(context, '/home');
  /// ```
  static Future<void> named(BuildContext context, String routeName,
      {Object? arguments, bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
    } else {
      return Navigator.pushNamed(context, routeName, arguments: arguments);
    }
  }

  /// Go back to previous screen
  ///
  /// Example:
  /// ```dart
  /// GoTo.back(context);
  /// ```
  static void back(BuildContext context, {int times = 1}) {
    if (times <= 1) {
      Navigator.pop(context);
    } else {
      Navigator.popUntil(context, (route) {
        times--;
        return times <= 0 || route.isFirst;
      });
    }
  }

  /// Go back to the first screen
  ///
  /// Example:
  /// ```dart
  /// GoTo.first(context);
  /// ```
  static void first(BuildContext context) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  /// Navigate with custom transition
  ///
  /// Example:
  /// ```dart
  /// GoTo.transition(
  ///   context,
  ///   MyScreen(),
  ///   transition: PageTransition.fade(),
  /// );
  /// ```
  static Future<void> transition(
    BuildContext context,
    Widget screen, {
    PageTransition? transition,
    bool replace = false,
  }) {
    if (transition != null) {
      if (replace) {
        return Navigator.pushReplacement(context, transition.getRoute(screen));
      } else {
        return Navigator.push(context, transition.getRoute(screen));
      }
    } else {
      return GoTo.screen(context, screen, replace: replace);
    }
  }
}

/// Base class for page transitions
abstract class PageTransition {
  Route getRoute(Widget screen);

  /// Fade transition
  factory PageTransition.fade({Duration? duration}) =
      _FadeTransition;

  /// Slide from right transition
  factory PageTransition.slideFromRight({Duration? duration}) =
      _SlideFromRightTransition;

  /// Slide from left transition
  factory PageTransition.slideFromLeft({Duration? duration}) =
      _SlideFromLeftTransition;

  /// Slide from top transition
  factory PageTransition.slideFromTop({Duration? duration}) =
      _SlideFromTopTransition;

  /// Slide from bottom transition
  factory PageTransition.slideFromBottom({Duration? duration}) =
      _SlideFromBottomTransition;
}

class _FadeTransition implements PageTransition {
  final Duration duration;

  _FadeTransition({Duration? duration}) : duration = duration ?? const Duration(milliseconds: 300);

  @override
  Route getRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: duration,
    );
  }
}

class _SlideFromRightTransition implements PageTransition {
  final Duration duration;

  _SlideFromRightTransition({Duration? duration}) : duration = duration ?? const Duration(milliseconds: 300);

  @override
  Route getRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }
}

class _SlideFromLeftTransition implements PageTransition {
  final Duration duration;

  _SlideFromLeftTransition({Duration? duration}) : duration = duration ?? const Duration(milliseconds: 300);

  @override
  Route getRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }
}

class _SlideFromTopTransition implements PageTransition {
  final Duration duration;

  _SlideFromTopTransition({Duration? duration}) : duration = duration ?? const Duration(milliseconds: 300);

  @override
  Route getRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }
}

class _SlideFromBottomTransition implements PageTransition {
  final Duration duration;

  _SlideFromBottomTransition({Duration? duration}) : duration = duration ?? const Duration(milliseconds: 300);

  @override
  Route getRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }
}