import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../../configs/constant_sizes.dart';

class AnimatedIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String imageName;
  final bool enabled;

  const AnimatedIconButton({
    required this.imageName,
    required this.onPressed,
    this.enabled = true,
    super.key,
  });

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton> {
  bool _isHovered = false;

  void _handleHover(bool hover) {
    setState(() => _isHovered = hover);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTap: widget.enabled ? widget.onPressed : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: context.autoAdaptive(s50),
          height: context.autoAdaptive(s50),
          child: Image.asset(
            widget.imageName,
            width: context.autoAdaptive(s50),
            height: context.autoAdaptive(s50),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
