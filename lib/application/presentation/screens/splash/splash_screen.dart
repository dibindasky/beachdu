import 'dart:async';
import 'package:beachdu/application/business_logic/auth/auth_bloc.dart';
import 'package:beachdu/application/presentation/routes/routes.dart';
import 'package:beachdu/application/presentation/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<AuthBloc>().add(const AuthEvent.logOrNot());
    });
    sizeFinder(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        loginOrNot(context, state.logOrNot);
      },
      child: Scaffold(
        body: Center(
          child: AnimatedSize(
            duration: const Duration(seconds: 1),
            child: SizedBox(
              height: sWidth * .19,
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  bechduMainlogo,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginOrNot(BuildContext context, bool toLogin) async {
    Future.delayed(const Duration(milliseconds: 2000), () {
      (!toLogin
          ? Navigator.pushReplacementNamed(context, Routes.onBoardingScreen)
          : Navigator.pushReplacementNamed(context, Routes.bottomBar));
    });
  }
}
