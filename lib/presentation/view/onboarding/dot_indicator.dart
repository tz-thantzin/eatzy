import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final int index;
  final int currentPage;

  const DotIndicator({
    super.key,
    required this.index,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration300,
      margin: EdgeInsets.only(right: context.autoAdaptive(s5)),
      height: context.autoAdaptive(s10),
      width: context.autoAdaptive(s20),
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryOrange : kLightYellow,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
    );
  }
}
