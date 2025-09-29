import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentText extends StatelessWidget {
  final String value;
  final Color fontColor;
  final double fontSize;
  final TextAlign? textAlign;

  const ContentText(
    this.value, {
    super.key,
    this.fontColor = kBlack,
    this.fontSize = s22,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textAlign: textAlign,
      style: GoogleFonts.leagueSpartan(
        textStyle: context.titleMedium.copyWith(
          color: fontColor,
          fontSize: context.autoAdaptive(fontSize),
          fontWeight: medium,
        ),
      ),
    );
  }
}
