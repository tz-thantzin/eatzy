import 'package:eatzy/presentation/configs/constant_colors.dart';
import 'package:flutter/material.dart';

import '../../presentation/configs/constant_sizes.dart';

const superBold = FontWeight.w900;
const bold = FontWeight.w700;
const semiBold = FontWeight.w600;
const medium = FontWeight.w500;
const light = FontWeight.w300;

extension ThemeEx on BuildContext {
  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kPrimaryYellow,
      appBarTheme: appBarTheme,
      textTheme: textTheme,
      textSelectionTheme: textSelectionTheme,
      colorScheme: colorScheme,
      iconTheme: iconTheme,
      highlightColor: kTransparent,
      focusColor: kPrimaryOrange,
      inputDecorationTheme: inputDecorationTheme,
    );
  }

  AppBarTheme get appBarTheme {
    return AppBarTheme(
      backgroundColor: kTransparent,
      elevation: 0,
      toolbarHeight: s100,
      titleTextStyle: Theme.of(
        this,
      ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
      foregroundColor: kPrimaryYellow,
    );
  }

  InputDecorationTheme get inputDecorationTheme {
    return const InputDecorationTheme(
      filled: true,
      fillColor: kTransparent,
      alignLabelWithHint: true,
    );
  }

  TextTheme get textTheme {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    ).apply(bodyColor: kBlack, displayColor: kBlack);
  }

  TextSelectionThemeData get textSelectionTheme {
    return TextSelectionThemeData(
      cursorColor: kGrey800,
      selectionColor: kGrey500,
      selectionHandleColor: kGrey800,
    );
  }

  IconThemeData get iconTheme {
    return const IconThemeData(color: kBlack);
  }

  ColorScheme get colorScheme {
    return ColorScheme(
      brightness: Brightness.light,
      primary: kPrimaryYellow,
      onPrimary: kBlack,
      secondary: kPrimaryOrange,
      onSecondary: kWhite,
      error: kError,
      onError: Colors.white,
      surface: kLightYellow,
      onSurface: kBlack,
    );
  }

  /// ---------------- Text Styles ----------------

  TextStyle get displayLarge =>
      const TextStyle(fontSize: s48, fontWeight: semiBold); // App titles
  TextStyle get displayMedium =>
      const TextStyle(fontSize: s40, fontWeight: semiBold); // Hero headlines
  TextStyle get displaySmall =>
      const TextStyle(fontSize: s34, fontWeight: bold); // Section headers

  TextStyle get headlineLarge =>
      const TextStyle(fontSize: s28, fontWeight: semiBold); // Headlines
  TextStyle get headlineMedium =>
      const TextStyle(fontSize: s24, fontWeight: semiBold);
  TextStyle get headlineSmall =>
      const TextStyle(fontSize: s22, fontWeight: bold);

  TextStyle get titleLarge =>
      const TextStyle(fontSize: s20, fontWeight: bold); // Page titles
  TextStyle get titleMedium => const TextStyle(fontSize: s18, fontWeight: bold);
  TextStyle get titleSmall => const TextStyle(fontSize: s16, fontWeight: bold);

  TextStyle get labelLarge =>
      const TextStyle(fontSize: s14, fontWeight: bold); // Buttons
  TextStyle get labelMedium =>
      const TextStyle(fontSize: s13, fontWeight: semiBold);
  TextStyle get labelSmall =>
      const TextStyle(fontSize: s12, fontWeight: semiBold);

  TextStyle get bodyLarge =>
      const TextStyle(fontSize: s16, fontWeight: medium); // Body
  TextStyle get bodyMedium =>
      const TextStyle(fontSize: s14, fontWeight: medium);
  TextStyle get bodySmall => const TextStyle(fontSize: s12, fontWeight: medium);

  TextStyle get caption =>
      const TextStyle(fontSize: s10, fontWeight: FontWeight.w400);
}
