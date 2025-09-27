import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:portfolio/utils/extensions/context_ex.dart';

extension LayoutAdapter on BuildContext {
  T adaptive<T>(T xs, T lg, {T? sm, T? md, T? xl}) {
    return layout.value<T>(
      xs: xs,
      sm: sm ?? (md ?? xs),
      md: md ?? sm,
      lg: lg,
      xl: xl ?? lg,
    );
  }

  double autoAdaptive(
    double def, {
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    // If developer provides only default size, calculate others proportionally
    final double base = def;

    return layout.value(
      xs: xs ?? base * 0.8, // smaller than default
      sm: sm ?? base * 0.9, // slightly smaller
      md: md ?? base, // default
      lg: lg ?? base * 1.4, // slightly bigger
      xl: xl ?? base * 1.8, // bigger
    );
  }

  double assignHeight(
    double fraction, {
    double additions = 0,
    double subs = 0,
  }) {
    return (screenHeight - (subs) + (additions)) * fraction;
  }

  double assignWidth(double fraction, {double additions = 0, double subs = 0}) {
    return (screenWidth - (subs) + (additions)) * fraction;
  }

  /// mobile < 780
  bool get isMobile => MediaQuery.of(this).size.width < 780;

  ///desktop >= 1100
  bool get isDesktop => MediaQuery.of(this).size.width >= 1100;

  double get appBarHeight => autoAdaptive(60);
}
