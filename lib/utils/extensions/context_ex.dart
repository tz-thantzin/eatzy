import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';

import '../../l10n/app_localizations.dart';

extension ContextX on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get sectionHeight =>
      MediaQuery.of(this).size.height - autoAdaptive(60);
  AppLocalizations get localization => AppLocalizations.of(this)!;

  double percentWidth(double percent) => screenWidth * (percent / 100);
  double percentHeight(double percent) => screenHeight * (percent / 100);
  SizedBox percentSizedBox({double? pWidth, double? pHeight}) => SizedBox(
    width: percentWidth(pWidth ?? 0),
    height: percentHeight(pHeight ?? 0),
  );
}
