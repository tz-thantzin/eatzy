import 'package:country_code_picker/country_code_picker.dart';
import 'package:eatzy/presentation/configs/constant_colors.dart';
import 'package:eatzy/presentation/configs/constant_sizes.dart';
import 'package:eatzy/presentation/view/widgets/text/title_text.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';

class PhoneNumberInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  final String? hintText;
  final String? errorText;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final ValueChanged<CountryCode>? onCountryCodeChanged;
  final ValueChanged<String>? onChanged;

  const PhoneNumberInputField({
    super.key,
    this.controller,
    this.title,
    this.hintText,
    this.errorText,
    this.focusNode,
    this.onEditingComplete,
    this.onCountryCodeChanged,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      if (title != null) ...[TitleText(title!), verticalSpaceSmall],
      TextFormField(
        key: key,
        controller: controller,
        keyboardType: TextInputType.phone,
        focusNode: focusNode,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: kGrey500),
          errorText: errorText,
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
            borderSide: const BorderSide(color: kPrimaryYellow, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.autoAdaptive(s16)),
            borderSide: const BorderSide(color: kError, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.autoAdaptive(s16)),
            borderSide: const BorderSide(color: kError, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.autoAdaptive(s16)),
            borderSide: const BorderSide(color: kGrey200, width: 1),
          ),
          prefixIcon: SizedBox(
            width: context.autoAdaptive(s90),
            child: Row(
              children: [
                CountryCodePicker(
                  onChanged: onCountryCodeChanged,
                  initialSelection: 'TH',
                  favorite: const ['+66', 'TH'],
                  showCountryOnly: false,
                  showFlag: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: false,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Colors.black),
                ),
                Container(width: 1, height: 30, color: kGrey300),
              ],
            ),
          ),
        ),
      ),
    ].addColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }
}
