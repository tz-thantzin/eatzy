import 'dart:async';

import 'package:eatzy/presentation/view/login/login_page.dart';
import 'package:eatzy/presentation/view/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/bloc/app/app_bloc.dart';
import '../presentation/view/error_view.dart';

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
          return currentPath == RoutePaths.login ? null : RoutePaths.login;
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
        path: RoutePaths.login,
        name: RouteName.login,
        builder: (context, state) => const LoginPage(),
      ),
    ],
    errorBuilder: (context, state) => const ErrorView(),
  );
}

class RouteName {
  static const initial = "/";
  static const loading = 'loading';
  static const onboarding = 'onboarding';
  static const login = 'login';
  static const signup = 'signup';
  static const home = "home";
}

class RoutePaths {
  static const initial = "/";
  static const loading = '/loading';
  static const login = "/login";
  static const signup = "/signup";
  static const home = "/home";
}
