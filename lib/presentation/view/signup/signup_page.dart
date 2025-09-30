import 'package:country_code_picker/country_code_picker.dart';
import 'package:eatzy/presentation/bloc/signup/signup_cubit.dart';
import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/presentation/view/widgets/buttons/icon_button.dart';
import 'package:eatzy/presentation/view/widgets/phone_number_input_field.dart';
import 'package:eatzy/presentation/view/widgets/widgets.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:eatzy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signupCubit = GetIt.I<SignupCubit>();

    return BlocProvider<SignupCubit>(
      create: (_) => signupCubit,
      child: const SignupView(),
    );
  }
}

class SignupView extends StatelessWidget {
  const SignupView();

  void _handleStateChange(BuildContext context, SignupState state) {
    /// Success but email not verified
    if (state.status == SignupStatus.success &&
        !(state.user?.isEmailVerified ?? false)) {
      context.read<SignupCubit>().sendEmailVerification();
      context.showCustomSnackBar(
        type: SnackBarType.warning,
        message: context.localization.email_not_verified,
      );
    }
    // Failure case
    else if (state.status == SignupStatus.failure) {
      context.showCustomSnackBar(
        type: SnackBarType.error,
        message: state.errorMessage != null
            ? state.authFailureMsg(context, state.errorMessage ?? '')
            : context.localization.unknown_error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryYellow,
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Image.asset(
            kBackIcon,
            height: context.autoAdaptive(s24),
            width: context.autoAdaptive(s24),
          ),
          onPressed: () => context.pop(), // go_router back navigation
        ),
        title: Text(
          context.localization.new_account,
          style: GoogleFonts.leagueSpartan(
            textStyle: context.titleLarge.copyWith(
              color: kWhite,
              fontSize: context.autoAdaptive(s24),
            ),
          ),
        ),
      ),
      body: BlocListener<SignupCubit, SignupState>(
        listenWhen: (SignupState prev, SignupState curr) =>
            prev.status != curr.status &&
            (curr.status == SignupStatus.failure ||
                curr.status == SignupStatus.success),
        listener: _handleStateChange,
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
          child: _SignupForm(),
        ).addAlign(alignment: Alignment.bottomCenter),
      ),
    );
  }
}

class _SignupForm extends StatefulWidget {
  const _SignupForm();

  @override
  State<_SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<_SignupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameCtrl = TextEditingController();
  final TextEditingController _signupEmailCtrl = TextEditingController();
  final TextEditingController _signupPassCtrl = TextEditingController();
  final TextEditingController _signupConfirmPassCtrl = TextEditingController();
  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 12),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null) {
      _dobCtrl.text = Utils.instance.formatDateToDDMMYYYY(picked);
      context.read<SignupCubit>().dobChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (_, SignupState state) {
        final bool canSubmit = state.isSignupValid;

        return <Widget>[
              TextInputField(
                controller: _fullNameCtrl,
                title: context.localization.full_name,
                hintText: context.localization.full_name,
                inputType: TextInputType.name,
                onChanged: (String value) =>
                    context.read<SignupCubit>().fullNameChanged(value.trim()),
                errorText: state.fullNameErrorText(context),
              ),
              verticalSpaceSmall,

              /// Input Email
              TextInputField(
                controller: _signupEmailCtrl,
                title: context.localization.email,
                hintText: context.localization.email,
                inputType: TextInputType.emailAddress,
                onChanged: (String value) =>
                    context.read<SignupCubit>().emailChanged(value.trim()),
                errorText: state.emailErrorText(context),
              ),
              verticalSpaceSmall,

              /// Input Password
              TextInputField(
                controller: _signupPassCtrl,
                title: context.localization.password,
                hintText: context.localization.password,
                obscureText: true,
                onChanged: (String value) =>
                    context.read<SignupCubit>().passwordChanged(value.trim()),
                errorText: state.passwordErrorText(context),
              ),
              verticalSpaceSmall,

              /// Input Confirm Password
              TextInputField(
                controller: _signupConfirmPassCtrl,
                title: context.localization.confirm_password,
                hintText: context.localization.confirm_password,
                obscureText: true,
                onChanged: (String value) => context
                    .read<SignupCubit>()
                    .confirmPasswordChanged(value.trim()),
                errorText: state.confirmPasswordErrorText(context),
              ),
              verticalSpaceSmall,

              /// Input Phone Number
              PhoneNumberInputField(
                controller: _phoneNumberCtrl,
                title: context.localization.mobile_number,
                hintText: context.localization.phone_number,
                onChanged: (String value) => context
                    .read<SignupCubit>()
                    .phoneNumberChanged(value.trim()),
                onCountryCodeChanged: (CountryCode cc) =>
                    context.read<SignupCubit>().countryCodeChanged(cc.code),
                errorText: state.phoneNumberErrorText(context),
              ),
              verticalSpaceSmall,

              /// Input dob
              TextInputField(
                controller: _dobCtrl,
                title: context.localization.dob,
                hintText: context.localization.dob_format,
                readOnly: true,
                onTap: () => _pickDate(context),
                errorText: state.dobErrorText(context),
              ),
              verticalSpaceLarge,

              // Terms & Conditions
              DescriptionText(
                context.localization.continue_you_agree_to,
              ).addAlign(alignment: Alignment.center),
              <Widget>[
                AnimatedTextButton(
                  context.localization.terms_of_use,
                  textColor: kPrimaryOrange,
                ),
                horizontalSpaceTiny,
                DescriptionText(context.localization.and),
                horizontalSpaceTiny,
                AnimatedTextButton(
                  context.localization.privacy_policy,
                  textColor: kPrimaryOrange,
                ),
              ].addRow(mainAxisAlignment: MainAxisAlignment.center),
              verticalSpaceSmall,

              /// Signup Button
              AnimatedSlideButton(
                width: context.screenWidth * 0.45,
                title: context.localization.signup,
                hasIcon: false,
                borderRadius: 50,
                isLoading: state.isInProgress,
                buttonColor: canSubmit ? kPrimaryOrange : kGrey500,
                onPressed: canSubmit
                    ? context.read<SignupCubit>().loginWithEmail
                    : null,
              ).addAlign(alignment: Alignment.center),
              verticalSpaceMedium,

              DescriptionText(
                context.localization.signup_with,
              ).addAlign(alignment: Alignment.center),
              verticalSpaceMedium,

              /// Google
              AnimatedIconButton(
                imageName: kGoogleIcon,
                onPressed: context.read<SignupCubit>().signupWithGoogle,
              ).addAlign(alignment: Alignment.center),
              verticalSpaceMedium,

              /// Signup
              <Widget>[
                DescriptionText(context.localization.already_have_account),
                horizontalSpaceTiny,
                AnimatedTextButton(
                  context.localization.login,
                  textColor: kPrimaryOrange,
                  onPressed: () => context.pop(),
                ),
              ].addRow(mainAxisAlignment: MainAxisAlignment.center),
            ]
            .addColumn(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
            )
            .addScrollView()
            .addForm(key: _formKey);
      },
    );
  }
}
