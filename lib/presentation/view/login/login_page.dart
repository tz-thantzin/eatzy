import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/presentation/view/widgets/buttons/icon_button.dart';
import 'package:eatzy/presentation/view/widgets/widgets.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/login/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = GetIt.I<LoginCubit>();

    return BlocProvider<LoginCubit>(
      create: (_) => loginCubit,
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView();

  void _handleStateChange(BuildContext context, LoginState state) {
    /// Success but email not verified
    if (state.status == LoginStatus.success &&
        !(state.user?.isEmailVerified ?? false)) {
      context.read<LoginCubit>().sendEmailVerification();
      context.showCustomSnackBar(
        type: SnackBarType.warning,
        message:
            'Your email is not verified. Please verify it and log in again.',
      );
    }
    // Failure case
    else if (state.status == LoginStatus.failure) {
      context.showCustomSnackBar(
        type: SnackBarType.error,
        message: state.errorMessage != null
            ? state.authFailureMsg(context, state.errorMessage ?? '')
            : 'Something went wrong. Please try again later.',
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
        title: Text(
          'Login',
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
            (curr.status == LoginStatus.failure ||
                curr.status == LoginStatus.success),
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
          child: _LoginForm(),
        ).addAlign(alignment: Alignment.bottomCenter),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _loginEmailCtrl = TextEditingController();
  final TextEditingController _loginPassCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (_, LoginState state) {
        final bool canSubmit = state.isLoginValid;

        return <Widget>[
              TitleText('Welcome', textAlign: TextAlign.start),
              verticalSpaceSmall,
              DescriptionText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
              ),
              verticalSpaceMassive,

              /// Input Email
              TextInputField(
                controller: _loginEmailCtrl,
                title: 'Email',
                hintText: 'Email',
                inputType: TextInputType.emailAddress,
                onChange: (String value) =>
                    context.read<LoginCubit>().emailChanged(value.trim()),
                errorText: state.emailErrorText(context),
              ),
              verticalSpaceLarge,

              /// Input Password
              TextInputField(
                controller: _loginPassCtrl,
                title: 'Password',
                hintText: 'Password',
                obscureText: true,
                onChange: (String value) =>
                    context.read<LoginCubit>().passwordChanged(value.trim()),
                errorText: state.passwordErrorText(context),
              ),
              verticalSpaceSmall,

              /// Forgot Password
              AnimatedTextButton(
                'Forgot Password',
                onPressed: () {},
              ).addAlign(alignment: Alignment.centerRight),
              verticalSpaceEnormous,

              /// Login Button
              AnimatedSlideButton(
                width: context.screenWidth * 0.45,
                title: 'Login',
                hasIcon: false,
                borderRadius: 50,
                buttonColor: canSubmit ? kPrimaryOrange : kGrey500,
                onPressed: canSubmit
                    ? context.read<LoginCubit>().loginWithEmail
                    : null,
              ).addAlign(alignment: Alignment.center),
              verticalSpaceMedium,

              DescriptionText(
                'or signup with',
              ).addAlign(alignment: Alignment.center),
              verticalSpaceMedium,

              /// Google
              AnimatedIconButton(
                imageName: kGoogleIcon,
                onPressed: () {},
              ).addAlign(alignment: Alignment.center),
              verticalSpaceMedium,

              /// Signup
              <Widget>[
                DescriptionText("Don't have account? "),
                AnimatedTextButton('Signup', textColor: kPrimaryOrange),
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
