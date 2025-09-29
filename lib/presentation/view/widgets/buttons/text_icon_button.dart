import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../configs/constant_colors.dart';
import '../../../configs/constant_sizes.dart';

class TextIconButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final String imageName;
  final bool enabled;

  const TextIconButton({
    required this.title,
    required this.imageName,
    required this.onPressed,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.autoAdaptive(s50),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Image.asset(
          imageName,
          width: context.autoAdaptive(s24),
          height: context.autoAdaptive(s24),
        ),
        label: Text(
          title,
          style: GoogleFonts.leagueSpartan(
            textStyle: context.labelLarge.copyWith(fontWeight: semiBold),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: kWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: kGrey500),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}
