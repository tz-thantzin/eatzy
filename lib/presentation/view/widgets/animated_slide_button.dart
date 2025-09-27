import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/presentations/configs/duration.dart';

import '../../presentations/configs/constant_colors.dart';
import '../../presentations/configs/constant_sizes.dart';

class AnimatedSlideButton extends StatefulWidget {
  AnimatedSlideButton({
    super.key,
    required this.title,
    this.titleStyle,
    this.width = s120,
    this.borderWidth = s1,
    this.height = s48,
    this.onPressed,
    this.hasIcon = true,
    this.iconColor = kWhite,
    this.buttonColor = kBlack,
    this.borderColor = kBlack,
    this.onHoverColor = kWhite,
    this.iconData = FontAwesomeIcons.telegram,
    this.iconSize = s14,
    this.duration = duration1000,
    this.curve = Curves.fastOutSlowIn,
    this.buttonStyle,
    this.isLoading = false,
  });

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
  final ButtonStyle? buttonStyle;
  final VoidCallback? onPressed;
  final Duration duration;
  final Curve curve;
  final bool hasIcon;
  final bool isLoading;

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
    _textAndIconColor =
        ColorTween(
          begin: widget.onHoverColor,
          end: widget.buttonColor,
        ).animate(_controller)..addListener(() {
          setState(() {});
        });

    _offsetAnimation =
        Tween<Offset>(
          begin: Offset(0, 0),
          end: Offset(0.5, 0),
        ).animate(_controller)..addListener(() {
          setState(() {});
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyMedium?.copyWith(
      color: _textAndIconColor.value,
      fontSize: s14,
      fontWeight: FontWeight.w400,
    );
    final ButtonStyle defaultButtonStyle = ElevatedButton.styleFrom(
      foregroundColor: widget.onHoverColor,
      backgroundColor: widget.onHoverColor,
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        side: BorderSide(width: 1, color: widget.borderColor),
      ),
    );
    return MouseRegion(
      key: ValueKey('MouseRegion_Animated_Slide_Button'),
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: Container(
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
                      child: Text(
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
        color: widget.buttonColor,
        curve: widget.curve,
      ),
    );
  }

  Widget childWithIcon() {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? style = textTheme.bodyMedium?.copyWith(
      color: _textAndIconColor.value,
      fontSize: s14,
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
              overflow: TextOverflow.ellipsis, // prevent overflow
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
                    size: 16.0,
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
