import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/entities/onboarding.dart';
import '../widgets/buttons/animated_slide_button.dart';
import 'dot_indicator.dart';

class OnboardingContent extends StatelessWidget {
  final Onboarding onboardingData;
  final VoidCallback? onNextPressed;
  final VoidCallback? onGetStartedPressed;
  final int currentPage;
  final int totalPages;

  const OnboardingContent({
    super.key,
    required this.onboardingData,
    this.onNextPressed,
    this.onGetStartedPressed,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Background image
        SizedBox(
          width: double.infinity,
          height: context.screenHeight,
          child: Image.asset(onboardingData.image, fit: BoxFit.cover),
        ),

        /// Bottom container
        Container(
          width: double.infinity,
          height: context.screenHeight * 0.4,
          padding: EdgeInsets.symmetric(
            horizontal: context.autoAdaptive(s20),
            vertical: context.autoAdaptive(s48),
          ),
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(s30),
              topRight: Radius.circular(s30),
            ),
          ),
          child:
              <Widget>[
                if (onboardingData.icon.isNotEmpty)
                  Image.asset(
                    onboardingData.icon,
                    width: context.autoAdaptive(s40),
                    height: context.autoAdaptive(s40),
                  ),

                verticalSpaceMassive,

                Text(
                  onboardingData.title,
                  style: GoogleFonts.inter(
                    fontSize: context.autoAdaptive(s24),
                    fontWeight: bold,
                    color: kPrimaryOrange,
                  ),
                ),

                verticalSpaceSmall,

                Text(
                  onboardingData.desc,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: context.autoAdaptive(s18),
                    color: kBlack,
                  ),
                  textAlign: TextAlign.center,
                ),

                verticalSpaceMassive,

                /// Dot indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    totalPages,
                    (index) =>
                        DotIndicator(index: index, currentPage: currentPage),
                  ),
                ),

                verticalSpaceEnormous,

                /// Next / Get Started Button
                AnimatedSlideButton(
                  height: context.autoAdaptive(s36),
                  title: currentPage == totalPages - 1 ? "Get Started" : "Next",
                  hasIcon: false,
                  borderRadius: s50,
                  onPressed: currentPage == totalPages - 1
                      ? onGetStartedPressed
                      : onNextPressed,
                ),
              ].addColumn(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
        ).addAlign(alignment: Alignment.bottomCenter),
      ],
    );
  }
}
