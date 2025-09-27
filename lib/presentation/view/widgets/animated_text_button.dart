import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/presentations/configs/duration.dart';
import 'package:portfolio/utils/extensions/layout_adapter_ex.dart';
import 'package:portfolio/utils/extensions/theme_ex.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_images.dart';
import '../../presentations/configs/constant_sizes.dart';

class AnimatedTextButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color hoverColor;
  final Color textColor;
  final double fontSize;
  final bool isLoading;

  const AnimatedTextButton(
    this.title, {
    this.onPressed,
    this.hoverColor = kIndigo,
    this.textColor = kWhite,
    this.isLoading = false,
    this.fontSize = s10,
    super.key,
  });

  @override
  State<AnimatedTextButton> createState() => _AnimatedTextButtonState();
}

class _AnimatedTextButtonState extends State<AnimatedTextButton>
    with SingleTickerProviderStateMixin {
  bool _isButtonHovered = false;
  late AnimationController _controller;
  late Animation<Offset> _arrowOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration300);

    _arrowOffset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.2, 0), // slide arrow slightly right
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleHover(bool hover) {
    setState(() => _isButtonHovered = hover);
    if (hover) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = _isButtonHovered
        ? widget.hoverColor
        : widget.textColor;

    return SizedBox(
      height: context.autoAdaptive(s24),
      child: MouseRegion(
        key: ValueKey('MouseRegion_Animated_Text_Button'),
        onEnter: (_) => _handleHover(true),
        onExit: (_) => _handleHover(false),
        child: GestureDetector(
          onTap: widget.isLoading ? null : widget.onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                SizedBox(
                  width: context.autoAdaptive(s14),
                  height: context.autoAdaptive(s14),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(kIndigo),
                  ),
                )
              else ...[
                AnimatedDefaultTextStyle(
                  duration: duration300,
                  curve: Curves.easeInOut,
                  style: context.labelLarge.copyWith(
                    fontSize: context.autoAdaptive(widget.fontSize),
                    color: effectiveColor,
                  ),
                  child: Text(widget.title),
                ),
                horizontalSpaceTiny,
                SlideTransition(
                  position: _arrowOffset,
                  child: SvgPicture.asset(
                    kRightArrowSVG,
                    height: context.autoAdaptive(s14),
                    width: context.autoAdaptive(s14),
                    colorFilter: ColorFilter.mode(
                      effectiveColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
