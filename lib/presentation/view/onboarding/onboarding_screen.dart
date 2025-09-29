import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/presentation/view/widgets/widgets.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app/app_bloc.dart';
import 'onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _completeOnboarding() {
    context.read<AppBloc>().add(OnboardingCompleted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            /// PageView with swipe
            PageView.builder(
              controller: _controller,
              onPageChanged: (value) => setState(() => _currentPage = value),
              itemCount: contents.length,
              itemBuilder: (context, index) {
                final item = contents[index];

                return OnboardingContent(
                  onboardingData: item,
                  currentPage: _currentPage,
                  totalPages: contents.length,
                  onNextPressed: () => _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  onGetStartedPressed: _completeOnboarding,
                );
              },
            ),

            /// Skip Button (Top-right)
            Positioned(
              top: 20,
              right: 20,
              child: AnimatedTextButton(
                'Skip',
                suffixIcon: Image.asset(
                  kRightArrow,
                  width: context.autoAdaptive(s8),
                  height: context.autoAdaptive(s13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
