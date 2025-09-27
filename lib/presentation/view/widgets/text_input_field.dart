import '../../style_theme.dart';
import '../../utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
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

  const TextInput({
    this.controller,
    this.focusNode,
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
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          ? AppTextStyle.hintTextStyle(context)
          : Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: AppColors.neutralWhite,
        hintStyle: AppTextStyle.hintTextStyle(context),
        errorText: widget.errorText,
        errorMaxLines: 2,
        contentPadding: EdgeInsets.symmetric(
          horizontal: Sizes.sizeS.w,
          vertical: Sizes.sizeM.h,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.sizeM.r),
          borderSide: BorderSide(color: AppColors.grey300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.sizeM.r),
          borderSide: BorderSide(
            color: widget.readOnly ? AppColors.grey300 : AppColors.selected,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.sizeM.r),
          borderSide: BorderSide(
            color: widget.readOnly ? Colors.transparent : AppColors.error,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.sizeM.r),
          borderSide: BorderSide(
            color: widget.readOnly ? Colors.transparent : AppColors.error,
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.sizeM.r),
          borderSide: BorderSide(color: AppColors.grey200, width: 1),
        ),
        prefixIcon: widget.prefixIcon,
        suffix: widget.suffix,
        suffixIcon:
            widget.suffixIcon ??
            (widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.grey700,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )
                : null),
      ),
    );
  }
}
