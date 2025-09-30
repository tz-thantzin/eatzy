import 'package:eatzy/presentation/bloc/app/app_bloc.dart';
import 'package:eatzy/routes/routes.dart';
import 'package:eatzy/utils/extensions/theme_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout/layout.dart';

import 'injection.dart';
import 'l10n/app_localizations.dart';

class EatzyApp extends StatefulWidget {
  const EatzyApp({super.key});

  @override
  State<EatzyApp> createState() => _EatzyAppState();
}

class _EatzyAppState extends State<EatzyApp> {
  late final AppBloc _appBloc;

  @override
  void initState() {
    super.initState();
    _appBloc = getIt<AppBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final router = createAppRouter(_appBloc);

    return Layout(
      child: BlocProvider.value(
        value: _appBloc,
        child: MaterialApp.router(
          title: 'Eatzy',
          theme: context.theme(),
          builder: (BuildContext context, Widget? child) {
            final mediaQuery = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQuery.copyWith(
                textScaler: TextScaler.linear(
                  mediaQuery.textScaler.scale(1.0).clamp(0.8, 1.2),
                ),
              ),
              child: child!,
            );
          },
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        ),
      ),
    );
  }
}
