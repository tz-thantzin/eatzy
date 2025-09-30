import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/presentation/view/widgets/widgets.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/routes.dart';
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
        message: context.localization.email_not_verified,
      );
    }
    // Failure case
    else if (state.status == LoginStatus.failure) {
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
        title: Text(
          context.localization.login,
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
              TitleText(
                context.localization.welcome,
                textAlign: TextAlign.start,
              ),
              verticalSpaceSmall,
              DescriptionText(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
              ),
              verticalSpaceMassive,

              /// Input Email
              TextInputField(
                controller: _loginEmailCtrl,
                title: context.localization.email,
                hintText: context.localization.email,
                inputType: TextInputType.emailAddress,
                onChanged: (String value) =>
                    context.read<LoginCubit>().emailChanged(value.trim()),
                errorText: state.emailErrorText(context),
              ),
              verticalSpaceLarge,

              /// Input Password
              TextInputField(
                controller: _loginPassCtrl,
                title: context.localization.password,
                hintText: context.localization.password,
                obscureText: true,
                onChanged: (String value) =>
                    context.read<LoginCubit>().passwordChanged(value.trim()),
                errorText: state.passwordErrorText(context),
              ),
              verticalSpaceSmall,

              /// Forgot Password
              AnimatedTextButton(
                context.localization.forgot_password,
                onPressed: () {},
              ).addAlign(alignment: Alignment.centerRight),
              verticalSpaceEnormous,

              /// Login Button
              AnimatedSlideButton(
                width: context.screenWidth * 0.45,
                title: context.localization.login,
                hasIcon: false,
                borderRadius: 50,
                isLoading: state.isLoginEmailInProgress,
                buttonColor: canSubmit ? kPrimaryOrange : kGrey500,
                onPressed: canSubmit
                    ? context.read<LoginCubit>().loginWithEmail
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
                isLoading: state.isLoginGoogleInProgress,
                onPressed: context.read<LoginCubit>().loginWithGoogle,
              ).addAlign(alignment: Alignment.center),
              verticalSpaceMedium,

              /// Signup
              <Widget>[
                DescriptionText(context.localization.not_have_account),
                horizontalSpaceTiny,
                AnimatedTextButton(
                  context.localization.signup,
                  textColor: kPrimaryOrange,
                  onPressed: () =>
                      GoRouter.of(context).pushNamed(RouteName.signup),
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
