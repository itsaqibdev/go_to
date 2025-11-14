import 'package:flutter/material.dart';
import '../go_to.dart';

/// Extension methods for easier navigation
extension GoToExtension on BuildContext {
  /// Navigate to a new screen
  ///
  /// Example:
  /// ```dart
  /// context.goTo(MyScreen());
  /// ```
  Future<void> goTo(Widget screen, {bool replace = false}) =>
      GoTo.screen(this, screen, replace: replace);

  /// Navigate to a named route
  ///
  /// Example:
  /// ```dart
  /// context.goToNamed('/home');
  /// ```
  Future<void> goToNamed(String routeName, {Object? arguments, bool replace = false}) =>
      GoTo.named(this, routeName, arguments: arguments, replace: replace);

  /// Go back to previous screen
  ///
  /// Example:
  /// ```dart
  /// context.goBack();
  /// ```
  void goBack({int times = 1}) => GoTo.back(this, times: times);

  /// Go back to the first screen
  ///
  /// Example:
  /// ```dart
  /// context.goToFirst();
  /// ```
  void goToFirst() => GoTo.first(this);

  /// Navigate with custom transition
  ///
  /// Example:
  /// ```dart
  /// context.goToWithTransition(
  ///   MyScreen(),
  ///   transition: PageTransition.fade(),
  /// );
  /// ```
  Future<void> goToWithTransition(
    Widget screen, {
    PageTransition? transition,
    bool replace = false,
  }) =>
      GoTo.transition(this, screen, transition: transition, replace: replace);
}