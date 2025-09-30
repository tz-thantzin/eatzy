import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class BodyWrapper extends StatefulWidget {
  final Widget child;
  const BodyWrapper({super.key, required this.child});

  @override
  State<BodyWrapper> createState() => _BodyWrapperState();
}

class _BodyWrapperState extends State<BodyWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: duration2000);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        width: double.infinity,
        height: context.screenHeight * 0.85,
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
        child: widget.child,
      ),
    );
  }
}
