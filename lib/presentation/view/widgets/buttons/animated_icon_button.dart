import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AnimatedIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String imageName;
  final bool enabled;
  final bool isLoading;

  const AnimatedIconButton({
    required this.imageName,
    required this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    super.key,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? widget.onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: context.autoAdaptive(s50),
        height: context.autoAdaptive(s50),
        child: widget.isLoading
            ? SpinKitWanderingCubes(
                color: kPrimaryOrange,
                size: context.autoAdaptive(s25),
              )
            : Image.asset(
                widget.imageName,
                width: context.autoAdaptive(s50),
                height: context.autoAdaptive(s50),
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
