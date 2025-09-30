import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

extension ContextX on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double percentWidth(double percent) => screenWidth * (percent / 100);
  double percentHeight(double percent) => screenHeight * (percent / 100);
  SizedBox percentSizedBox({double? pWidth, double? pHeight}) => SizedBox(
    width: percentWidth(pWidth ?? 0),
    height: percentHeight(pHeight ?? 0),
  );

  AppLocalizations get localization => AppLocalizations.of(this)!;

  void showCustomSnackBar({
    required String message,
    SnackBarType type = SnackBarType.info,
    IconData? icon,
    Color textColor = kWhite,
    Duration duration = duration3000,
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          duration: duration,
          padding: EdgeInsets.zero,
          content: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: autoAdaptive(s16),
                vertical: autoAdaptive(s16),
              ),
              decoration: BoxDecoration(
                color: _getSnackBarColor(type: type),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(autoAdaptive(s16)),
                  topRight: Radius.circular(autoAdaptive(s16)),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  if (icon != null) ...<Widget>[
                    Icon(icon, color: textColor),
                    horizontalSpaceMedium,
                  ],
                  Expanded(
                    child: Text(
                      message,
                      style: labelLarge.copyWith(
                        color: textColor,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }

  Color _getSnackBarColor({SnackBarType type = SnackBarType.info}) {
    switch (type) {
      case SnackBarType.success:
        return kSuccess;
      case SnackBarType.error:
        return kError;
      case SnackBarType.warning:
        return kWarning;
      default:
        return kInfo;
    }
  }
}
