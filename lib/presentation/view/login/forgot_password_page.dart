import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/presentation/view/widgets/widgets.dart';
import 'package:eatzy/presentation/view/wrapper.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/login/login_cubit.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = GetIt.I<LoginCubit>();

    return BlocProvider<LoginCubit>(
      create: (_) => loginCubit,
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView();

  void _handleStateChange(BuildContext context, LoginState state) {
    /// Success and display reset password link sent to email.
    if (state.status == LoginStatus.resetPasswordSuccess) {
      context.showCustomSnackBar(
        type: SnackBarType.success,
        message: context.localization.sent_reset_password_link,
      );
      context.back();
    }
    // Failure case
    else if (state.status == LoginStatus.resetPasswordFailure) {
      context.showCustomSnackBar(
        type: SnackBarType.success,
        message: state.errorMessage != null
            ? state.authFailureMsg(context, state.errorMessage!)
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
          onPressed: () => context.back(),
        ),
        title: Text(
          context.localization.forgot_password,
          style: GoogleFonts.leagueSpartan(
            textStyle: context.titleLarge.copyWith(
              color: kWhite,
              fontSize: context.autoAdaptive(s24),
            ),
          ),
        ),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listenWhen: (LoginState prev, LoginState curr) =>
            prev.status != curr.status &&
            (curr.status == LoginStatus.resetPasswordSuccess ||
                curr.status == LoginStatus.resetPasswordFailure),
        listener: _handleStateChange,
        child: _ForgotPasswordForm().addAlign(
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class _ForgotPasswordForm extends StatefulWidget {
  const _ForgotPasswordForm();

  @override
  State<_ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<_ForgotPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _resetPasswordEmailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BodyWrapper(
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (_, LoginState state) {
          final bool canSubmit = state.isForgotPasswordValid;
          print('state $state');
          return <Widget>[
                DescriptionText(
                  context.localization.forgot_password_description,
                ),
                verticalSpaceMassive,

                /// Input Email
                TextInputField(
                  controller: _resetPasswordEmailCtrl,
                  title: context.localization.email,
                  hintText: context.localization.email,
                  inputType: TextInputType.emailAddress,
                  onChanged: (String value) => context
                      .read<LoginCubit>()
                      .resetPasswordEmailChanged(value.trim()),
                  errorText: state.emailErrorText(context),
                ),
                verticalSpaceLarge,

                /// Submit Button
                AnimatedSlideButton(
                  width: context.screenWidth * 0.45,
                  title: context.localization.submit,
                  hasIcon: false,
                  borderRadius: 50,
                  isLoading: state.isResetPasswordInProgress,
                  buttonColor: canSubmit ? kPrimaryOrange : kGrey500,
                  onPressed: canSubmit
                      ? context.read<LoginCubit>().sendResetEmail
                      : null,
                ).addAlign(alignment: Alignment.center),
                verticalSpaceMedium,
              ]
              .addColumn(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
              )
              .addScrollView()
              .addForm(key: _formKey);
        },
      ),
    );
  }
}
