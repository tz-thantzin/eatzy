import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../configs/configs.dart';

class AnimatedTextButton extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color hoverColor;
  final Color textColor;
  final double fontSize;
  final bool isLoading;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const AnimatedTextButton(
    this.title, {
    this.onPressed,
    this.hoverColor = kLightYellow,
    this.textColor = kPrimaryOrange,
    this.isLoading = false,
    this.fontSize = s10,
    this.prefixIcon,
    this.suffixIcon,
    super.key,
  });

  @override
  State<AnimatedTextButton> createState() => _AnimatedTextButtonState();
}

class _AnimatedTextButtonState extends State<AnimatedTextButton>
    with SingleTickerProviderStateMixin {
  bool _isButtonHovered = false;
  late AnimationController _controller;
  late Animation<Offset> _prefixOffset;
  late Animation<Offset> _suffixOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration300);

    _prefixOffset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-s03, 0), // slide arrow slightly left
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _suffixOffset = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(s03, 0), // slide arrow slightly right
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
                  child: SizedBox(
                    width: context.autoAdaptive(s14),
                    height: context.autoAdaptive(s14),
                    child: SpinKitWanderingCubes(
                      color: kPrimaryOrange,
                      size: 16.0,
                    ),
                  ),
                )
              else ...[
                if (widget.prefixIcon != null) ...{
                  SlideTransition(
                    position: _prefixOffset,
                    child: IconTheme(
                      data: IconThemeData(color: effectiveColor),
                      child: widget.prefixIcon!,
                    ),
                  ),
                  horizontalSpaceTiny,
                },
                AnimatedDefaultTextStyle(
                  duration: duration300,
                  curve: Curves.easeInOut,
                  style: GoogleFonts.leagueSpartan(
                    textStyle: context.labelLarge.copyWith(
                      color: effectiveColor,
                      fontWeight: semiBold,
                    ),
                  ),
                  child: Text(widget.title),
                ),
                if (widget.suffixIcon != null) ...{
                  horizontalSpaceTiny,
                  SlideTransition(
                    position: _suffixOffset,
                    child: IconTheme(
                      data: IconThemeData(color: effectiveColor),
                      child: widget.suffixIcon!,
                    ),
                  ),
                },
              ],
            ],
          ),
        ),
      ),
    );
  }
}
