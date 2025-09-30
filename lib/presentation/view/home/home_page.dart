import 'package:eatzy/presentation/bloc/app/app_bloc.dart';
import 'package:eatzy/presentation/configs/configs.dart';
import 'package:eatzy/presentation/view/widgets/widgets.dart';
import 'package:eatzy/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightYellow,
      body:
          <Widget>[
            TitleText('Home'),
            verticalSpaceLarge,
            AnimatedSlideButton(
              width: context.screenWidth * 0.45,
              title: 'Logout',
              hasIcon: false,
              borderRadius: 50,
              buttonColor: kPrimaryOrange,
              onPressed: () => context.read<AppBloc>().add(LogoutPressed()),
            ).addAlign(alignment: Alignment.center),
          ].addColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
    );
  }
}
