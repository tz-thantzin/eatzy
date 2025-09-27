import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/views/about_me/about_page.dart';
import 'package:portfolio/views/contact/contact_page.dart';
import 'package:portfolio/views/error_view.dart';
import 'package:portfolio/views/home/home_page.dart';
import 'package:portfolio/views/portfolio/portfolio_page.dart';
import 'package:portfolio/views/skill/skills_page.dart';
import 'package:portfolio/views/work_experience/work_experiences_page.dart';

class NavigationArguments {
  final bool showCustomAnimation;

  NavigationArguments({this.showCustomAnimation = true});
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePaths.initial,
    routes: [
      _route(
        path: RoutePaths.initial,
        name: RouteName.initial,
        builder: (context, state) {
          final args = state.extra as NavigationArguments?;
          return HomePage(
            showCustomAnimation: args?.showCustomAnimation ?? true,
          );
        },
      ),
      _route(
        path: RoutePaths.home,
        name: RouteName.home,
        builder: (context, state) {
          final args = state.extra as NavigationArguments?;
          return HomePage(
            showCustomAnimation: args?.showCustomAnimation ?? true,
          );
        },
      ),
      _route(
        path: RoutePaths.about,
        name: RouteName.about,
        builder: (context, state) => const AboutMePage(),
      ),
      _route(
        path: RoutePaths.experience,
        name: RouteName.experience,
        builder: (context, state) => const WorkExperiencePage(),
      ),
      _route(
        path: RoutePaths.portfolio,
        name: RouteName.portfolio,
        builder: (context, state) => const PortfolioPage(),
      ),
      _route(
        path: RoutePaths.skills,
        name: RouteName.skills,
        builder: (context, state) => const SkillsView(),
      ),
      _route(
        path: RoutePaths.contact,
        name: RouteName.contact,
        builder: (context, state) => const ContactPage(),
      ),
    ],
    errorBuilder: (context, state) => const ErrorView(),
  );

  static GoRoute _route({
    required String path,
    required Widget Function(BuildContext, GoRouterState) builder,
    String? name,
  }) {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) {
        final child = builder(context, state);
        return NoTransitionPage(key: state.pageKey, child: child);
      },
    );
  }
}

class RouteName {
  static const initial = "/";
  static const home = "home";
  static const about = "about";
  static const experience = "experience";
  static const portfolio = "portfolio";
  static const skills = "skills";
  static const contact = "contact";
}

class RoutePaths {
  static const initial = "/";
  static const home = "/home";
  static const about = "/about";
  static const experience = "/experience";
  static const portfolio = "/portfolio";
  static const skills = "/skills";
  static const contact = "/contact";
}
