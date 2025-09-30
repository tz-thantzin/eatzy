import 'dart:async';
import 'dart:developer';

import 'package:eatzy/presentation/view/home/home_page.dart';
import 'package:eatzy/presentation/view/loading_view.dart';
import 'package:eatzy/presentation/view/login/forgot_password_page.dart';
import 'package:eatzy/presentation/view/login/login_page.dart';
import 'package:eatzy/presentation/view/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/bloc/app/app_bloc.dart';
import '../presentation/view/error_view.dart';
import '../presentation/view/signup/signup_page.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

GoRouter createAppRouter(AppBloc appBloc) {
  return GoRouter(
    initialLocation: RoutePaths.initial,
    refreshListenable: GoRouterRefreshStream(appBloc.stream),
    redirect: (BuildContext context, GoRouterState state) {
      final currentPath = state.uri.path;
      final status = appBloc.state.status;

      switch (status) {
        case AppStatus.firstLaunch:
          return currentPath == RoutePaths.initial ? null : RoutePaths.initial;

        case AppStatus.authenticated:
          if (currentPath == RoutePaths.home) return null;
          return RoutePaths.home;

        case AppStatus.unauthenticated:
          if (currentPath == RoutePaths.login ||
              currentPath == RoutePaths.signup ||
              currentPath == RoutePaths.forgotPassword) {
            return null;
          }
          return RoutePaths.login;

        case AppStatus.authenticating:
          return currentPath == RoutePaths.loading ? null : RoutePaths.loading;
      }
    },
    routes: [
      GoRoute(
        path: RoutePaths.initial,
        name: RouteName.initial,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RoutePaths.loading,
        name: RouteName.loading,
        builder: (context, state) => const LoadingView(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteName.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.signup,
        name: RouteName.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: RoutePaths.home,
        name: RouteName.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        name: RouteName.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
    ],
    errorBuilder: (context, state) {
      log('Routes:', error: state.error);
      // This will show the exact error
      return ErrorView();
    },
  );
}

class RouteName {
  static const initial = "/";
  static const loading = 'loading';
  static const onboarding = 'onboarding';
  static const login = 'login';
  static const signup = 'signup';
  static const forgotPassword = 'forgotPassword';
  static const home = "home";
}

class RoutePaths {
  static const initial = "/";
  static const loading = '/loading';
  static const login = "/login";
  static const signup = "/signup";
  static const forgotPassword = "/forgotPassword";
  static const home = "/home";
}
