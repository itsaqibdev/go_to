import 'package:flutter/material.dart';

/// A widget that provides advanced navigation capabilities
class GoToNavigator extends StatefulWidget {
  final Widget home;
  final Map<String, Widget Function(BuildContext)> routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver> observers;

  const GoToNavigator({
    super.key,
    required this.home,
    this.routes = const {},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.observers = const [],
  });

  @override
  State<GoToNavigator> createState() => _GoToNavigatorState();
}

class _GoToNavigatorState extends State<GoToNavigator> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: widget.initialRoute,
      onGenerateRoute: _onGenerateRoute,
      onUnknownRoute: widget.onUnknownRoute,
      observers: widget.observers,
    );
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    // Check if we have a custom route generator
    if (widget.onGenerateRoute != null) {
      final route = widget.onGenerateRoute!(settings);
      if (route != null) return route;
    }

    // Check if we have a named route
    if (widget.routes.containsKey(settings.name)) {
      return MaterialPageRoute(
        builder: (context) => widget.routes[settings.name]!(context),
        settings: settings,
      );
    }

    // Return home if no route matches
    return MaterialPageRoute(
      builder: (context) => widget.home,
      settings: settings,
    );
  }

  /// Get the navigator state
  NavigatorState? get navigator => _navigatorKey.currentState;
}

/// Controller for GoToNavigator
class GoToController {
  final GlobalKey<NavigatorState> _navigatorKey;

  GoToController._(this._navigatorKey);

  /// Navigate to a new screen
  Future<T?> push<T extends Object?>(Widget screen) {
    return _navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  /// Navigate to a named route
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return _navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }

  /// Replace current screen
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Widget screen, {
    TO? result,
  }) {
    return _navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (context) => screen),
      result: result,
    );
  }

  /// Replace current screen with named route
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return _navigatorKey.currentState!
        .pushReplacementNamed<T, TO>(routeName, result: result, arguments: arguments);
  }

  /// Push and remove all screens until predicate returns true
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Widget screen,
    RoutePredicate predicate,
  ) {
    return _navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      predicate,
    );
  }

  /// Push named route and remove all screens until predicate returns true
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return _navigatorKey.currentState!
        .pushNamedAndRemoveUntil<T>(newRouteName, predicate, arguments: arguments);
  }

  /// Pop current screen
  void pop<T extends Object?>([T? result]) {
    _navigatorKey.currentState!.pop(result);
  }

  /// Pop multiple screens
  void popTimes(int times) {
    for (int i = 0; i < times; i++) {
      if (_navigatorKey.currentState!.canPop()) {
        _navigatorKey.currentState!.pop();
      } else {
        break;
      }
    }
  }

  /// Pop until predicate returns true
  void popUntil(RoutePredicate predicate) {
    _navigatorKey.currentState!.popUntil(predicate);
  }
}