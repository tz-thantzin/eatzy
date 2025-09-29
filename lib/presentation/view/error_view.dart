import 'package:eatzy/presentation/configs/constant_colors.dart';
import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: Text('Something went wrong. Please try again later!'),
      ),
    );
  }
}
