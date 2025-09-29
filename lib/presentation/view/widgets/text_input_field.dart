import 'package:eatzy/presentation/configs/constant_images.dart';
import 'package:eatzy/presentation/view/widgets/text/title_text.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../configs/constant_colors.dart';
import '../../configs/constant_sizes.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType inputType;
  final FocusNode? focusNode;
  final String? title;
  final String? hintText;
  final bool obscureText;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String? errorText;
  final bool readOnly;

  const TextInputField({
    this.controller,
    this.inputType = TextInputType.text,
    this.focusNode,
    this.title,
    this.hintText,
    this.obscureText = false,
    this.onChange,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.suffix,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.readOnly = false,
    super.key,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      if (widget.title != null) ...[
        TitleText(widget.title!),
        SizedBox(height: context.autoAdaptive(s8)),
      ],
      TextFormField(
        controller: widget.controller,
        key: widget.key,
        obscureText: _isObscure,
        readOnly: widget.readOnly,
        showCursor: !widget.readOnly,
        enableInteractiveSelection: !widget.readOnly,
        onChanged: widget.onChange,
        onFieldSubmitted: widget.onFieldSubmitted,
        onEditingComplete: widget.onEditingComplete,
        style: widget.readOnly
            ? Theme.of(context).textTheme.bodyMedium!.copyWith(color: kGrey500)
            : Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: kGrey500),
          errorText: widget.errorText,
          errorMaxLines: 2,
          filled: true,
          fillColor: kLightYellow,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.autoAdaptive(s8),
            vertical: context.autoAdaptive(s16),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.autoAdaptive(s16)),
            borderSide: const BorderSide(color: kGrey300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.autoAdaptive(s16)),
            borderSide: BorderSide(
              color: widget.readOnly ? kGrey300 : kPrimaryYellow,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.autoAdaptive(s16)),
            borderSide: BorderSide(
              color: widget.readOnly ? kTransparent : kError,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.autoAdaptive(s16)),
            borderSide: BorderSide(
              color: widget.readOnly ? kTransparent : kError,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.autoAdaptive(s16)),
            borderSide: const BorderSide(color: kGrey200, width: 1),
          ),
          prefixIcon: widget.prefixIcon,
          suffix: widget.suffix,
          suffixIcon:
              widget.suffixIcon ??
              (widget.obscureText
                  ? IconButton(
                      icon: Image.asset(
                        _isObscure ? kShowOffIcon : kShowOnIcon,
                        width: context.autoAdaptive(s20),
                        height: context.autoAdaptive(s20),
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : null),
        ),
      ),
    ].addColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }
}
