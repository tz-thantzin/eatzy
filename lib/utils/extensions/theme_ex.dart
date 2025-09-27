import 'package:flutter/material.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';

const superBold = FontWeight.w900;
const bold = FontWeight.w700;
const semiBold = FontWeight.w600;
const medium = FontWeight.w500;
const light = FontWeight.w300;

extension ThemeEx on BuildContext {
  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kPrimary,
      appBarTheme: appBarTheme,
      textTheme: textTheme,
      textSelectionTheme: textSelectionTheme,
      colorScheme: colorScheme,
      iconTheme: iconTheme,
      highlightColor: kTransparent,
      focusColor: kPrimary,
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
      foregroundColor: kBlue,
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
      cursorColor: kPrimary,
      selectionColor: kGrey500,
      selectionHandleColor: kPrimary,
    );
  }

  IconThemeData get iconTheme {
    return const IconThemeData(color: kBlack);
  }

  ColorScheme get colorScheme {
    return ColorScheme(
      brightness: Brightness.light,
      primary: kPrimary,
      onPrimary: kPrimary,
      secondary: kSecondary,
      onSecondary: kSecondary,
      error: kRed,
      onError: kRed100,
      surface: kGrey100,
      onSurface: kGrey100,
    );
  }

  /// ---------------- Text Styles ----------------
  TextStyle get displayLarge =>
      const TextStyle(fontSize: s96, fontWeight: semiBold);
  TextStyle get displayMedium =>
      const TextStyle(fontSize: s70, fontWeight: semiBold);
  TextStyle get displaySmall =>
      const TextStyle(fontSize: s60, fontWeight: bold);

  TextStyle get headlineLarge =>
      const TextStyle(fontSize: s100, fontWeight: semiBold);
  TextStyle get headlineMedium =>
      const TextStyle(fontSize: s80, fontWeight: semiBold);
  TextStyle get headlineSmall =>
      const TextStyle(fontSize: s64, fontWeight: bold);

  TextStyle get titleLarge => TextStyle(fontSize: s48, fontWeight: bold);
  TextStyle get titleMedium => const TextStyle(fontSize: s42, fontWeight: bold);
  TextStyle get titleSmall => const TextStyle(fontSize: s36, fontWeight: bold);

  TextStyle get labelLarge => const TextStyle(fontSize: s28, fontWeight: bold);
  TextStyle get labelMedium =>
      const TextStyle(fontSize: s24, fontWeight: semiBold);
  TextStyle get labelSmall =>
      const TextStyle(fontSize: s20, fontWeight: semiBold);

  TextStyle get bodyLarge =>
      const TextStyle(fontSize: s20, fontWeight: medium, color: kBlack);
  TextStyle get bodyMedium =>
      const TextStyle(fontSize: s16, fontWeight: medium, color: kBlack);
  TextStyle get bodySmall => const TextStyle(fontSize: s14, fontWeight: medium);

  TextStyle get caption =>
      const TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: kBlack);
  //
  // TextStyle get navTitleTextStyle => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontWeight: FontWeight.bold,
  //   color: kBlue,
  //   fontSize: scaleFontSize(16),
  // );
  //
  // TextStyle get navItemTextStyle => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontWeight: FontWeight.w500,
  //   color: kBlue,
  //   fontSize: scaleFontSize(11),
  // );

  // TextStyle get navItemSelectedTextStyle =>
  //     navItemTextStyle.copyWith(fontWeight: FontWeight.w900, color: kBlue);
  //
  // TextStyle get displayLarge => TextStyle(
  //   fontFamily: 'RobotoCondensedLocal',
  //   fontSize: scaleFontSize(32),
  //   color: colorScheme.primary,
  //   fontWeight: FontWeight.bold,
  // );
  //
  // TextStyle get displayMedium => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(20),
  //   color: colorScheme.onSurface,
  //   fontWeight: FontWeight.bold,
  // );
  //
  // TextStyle get displaySmall => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(14),
  //   color: colorScheme.primary,
  //   fontWeight: FontWeight.bold,
  // );
  //
  // TextStyle get bodyLarge => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(14),
  //   color: colorScheme.onSurface.withValues(alpha: 0.6),
  // );
  //
  // TextStyle get headlineLarge => TextStyle(
  //   fontFamily: 'BungeeLocal',
  //   fontSize: scaleFontSize(20),
  //   color: kBlue,
  //   fontWeight: FontWeight.bold,
  // );
  //
  // TextStyle get headlineMedium => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(14),
  //   color: colorScheme.onSurface,
  // );
  //
  // TextStyle get headlineSmall => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(11),
  //   color: colorScheme.onSurface,
  // );
  //
  // TextStyle get tagTextStyle => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(10),
  //   color: colorScheme.primary,
  // );
  //
  // TextStyle get titleLarge => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(14),
  //   fontWeight: FontWeight.w600,
  //   color: colorScheme.onSurface,
  // );
  //
  // TextStyle get titleMedium => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(12),
  //   fontWeight: FontWeight.normal,
  //   color: colorScheme.onSurface,
  // );
  //
  // TextStyle get titleSmall => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(10),
  //   color: colorScheme.onSurface.withValues(alpha: 0.6),
  // );
  //
  // TextStyle get bodySmall => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(10),
  //   color: colorScheme.onSurface.withValues(alpha: 0.5),
  // );
  //
  // TextStyle get bodyMedium => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(12),
  //   color: colorScheme.onSurface.withValues(alpha: 0.6),
  // );
  //
  // TextStyle get labelLarge => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(14),
  //   color: kWhite,
  // );
  //
  // TextStyle get navDrawerTitleTextStyle => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(16),
  //   color: kWhite,
  //   fontWeight: FontWeight.w600,
  // );
  //
  // TextStyle get navDrawerDescriptionTextStyle => TextStyle(
  //   fontFamily: 'MulishLocal',
  //   fontSize: scaleFontSize(14),
  //   color: kWhite70,
  // );
}
