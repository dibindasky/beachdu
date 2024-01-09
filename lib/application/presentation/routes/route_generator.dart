
import 'package:beachdu/application/presentation/routes/routes.dart';
import 'package:beachdu/application/presentation/screens/auth/auth_screen.dart';
import 'package:beachdu/application/presentation/screens/home/home_screen.dart';
import 'package:beachdu/application/presentation/screens/pickup/pickup_screen.dart';
import 'package:beachdu/application/presentation/screens/product/product_screen.dart';
import 'package:beachdu/application/presentation/screens/questions/questions_screen.dart';
import 'package:beachdu/application/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  Route onGenerateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.initial:
        return MaterialPageRoute(builder: (ctx) => const ScreenSplash());
      case Routes.signIn:
        return MaterialPageRoute(builder: (ctx) => const ScreenAuth());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (ctx) => const ScreenHome());
      case Routes.pickUpDetailScreen:
        return MaterialPageRoute(builder: (ctx) => const ScreenPickUp());
      case Routes.questions:
        return MaterialPageRoute(builder: (ctx) => const ScreenQuestions());
      case Routes.searchScreen:
        return MaterialPageRoute(builder: (ctx) => const ScreenProductSelection());
      // case Routes.questions:
      //   return arguments is String
      //       ? MaterialPageRoute(
      //           builder: (ctx) => ScreenQuestions(aa: arguments,))
      //       : _errorScreen();
      default:
        return _errorScreen();
    }
  }

  static Route<dynamic> _errorScreen() {
    return MaterialPageRoute(builder: (ctx) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Error while navigating')),
      );
    });
  }
}