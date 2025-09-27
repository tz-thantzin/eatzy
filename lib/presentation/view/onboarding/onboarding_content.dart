import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String desc;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Image with fade-in
          SizedBox(
            height: height * 0.4,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1.0),
              duration: const Duration(milliseconds: 500),
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: Image.asset(image));
              },
            ),
          ),
          const SizedBox(height: 30),

          /// Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: (width <= 550) ? 30 : 35,
            ),
          ),
          const SizedBox(height: 15),

          /// Scrollable description
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: (width <= 550) ? 17 : 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
