import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedSlideButton extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final IconData iconData;
  final double iconSize;
  final Color iconColor;
  final Color buttonColor;
  final Color borderColor;
  final Color onHoverColor;
  final double width;
  final double borderWidth;
  final double height;
  final double borderRadius;
  final ButtonStyle? buttonStyle;
  final VoidCallback? onPressed;
  final Duration duration;
  final Curve curve;
  final bool hasIcon;
  final bool isLoading;

  const AnimatedSlideButton({
    super.key,
    required this.title,
    this.titleStyle,
    this.width = s120,
    this.borderWidth = s1,
    this.height = s48,
    this.onPressed,
    this.hasIcon = true,
    this.iconColor = kPrimaryOrange,
    this.buttonColor = kPrimaryOrange,
    this.borderColor = kPrimaryOrange,
    this.onHoverColor = kLightYellow,
    this.iconData = FontAwesomeIcons.telegram,
    this.iconSize = s14,
    this.duration = duration1000,
    this.curve = Curves.fastOutSlowIn,
    this.buttonStyle,
    this.isLoading = false,
    this.borderRadius = 8.0,
  });

  @override
  State<AnimatedSlideButton> createState() => _AnimatedSlideButtonState();
}

class _AnimatedSlideButtonState extends State<AnimatedSlideButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _textAndIconColor;
  late Animation<Offset> _offsetAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _textAndIconColor = ColorTween(
      begin: widget.onHoverColor,
      end: widget.buttonColor,
    ).animate(_controller)..addListener(() => setState(() {}));

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0.5, 0),
    ).animate(_controller)..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? style = GoogleFonts.leagueSpartan(
      textStyle: context.labelLarge.copyWith(
        color: _textAndIconColor.value,
        fontWeight: semiBold,
      ),
    );

    final ButtonStyle defaultButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: widget.onHoverColor,
      backgroundColor: widget.onHoverColor,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        side: BorderSide(width: widget.borderWidth, color: widget.borderColor),
      ),
    );

    return MouseRegion(
      key: UniqueKey(),
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: widget.buttonStyle ?? defaultButtonStyle,
          child: widget.hasIcon
              ? Stack(children: [animatedBackground(), childWithIcon()])
              : Stack(
                  children: [
                    animatedBackground(),
                    Center(
                      child: widget.isLoading
                          ? SpinKitWanderingCubes(
                              color: _textAndIconColor.value,
                              size: context.autoAdaptive(s25),
                            )
                          : Text(
                              widget.title,
                              style: widget.titleStyle ?? style,
                            ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget animatedBackground() {
    return Positioned(
      right: 0,
      child: AnimatedContainer(
        duration: widget.duration,
        width: _isHovering ? 0 : widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        curve: widget.curve,
      ),
    );
  }

  Widget childWithIcon() {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyMedium?.copyWith(
      color: _textAndIconColor.value,
      fontSize: context.autoAdaptive(s18),
      fontWeight: FontWeight.w400,
    );

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              widget.title,
              style: widget.titleStyle ?? style,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
          horizontalSpaceSmall,
          SlideTransition(
            position: _offsetAnimation,
            child: widget.isLoading
                ? SpinKitWanderingCubes(
                    color: _textAndIconColor.value,
                    size: context.autoAdaptive(s25),
                  )
                : Icon(
                    widget.iconData,
                    size: widget.iconSize,
                    color: _textAndIconColor.value,
                  ),
          ),
        ],
      ),
    );
  }

  void _mouseEnter(bool hovering) {
    if (hovering) {
      setState(() {
        if (widget.onPressed != null) {
          _controller.forward();
          _isHovering = hovering;
        }
      });
    } else {
      setState(() {
        _controller.reverse();
        _isHovering = hovering;
      });
    }
  }
}
