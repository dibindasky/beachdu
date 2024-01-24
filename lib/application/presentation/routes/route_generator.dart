import 'package:beachdu/application/presentation/routes/animated_routes.dart';
import 'package:beachdu/application/presentation/routes/routes.dart';
import 'package:beachdu/application/presentation/screens/auth/login_screen.dart';
import 'package:beachdu/application/presentation/screens/auth/otp_screen.dart';
import 'package:beachdu/application/presentation/screens/home/home_screen.dart';
import 'package:beachdu/application/presentation/screens/navbar/bottombar.dart';
import 'package:beachdu/application/presentation/screens/pickup/pickup_screen.dart';
import 'package:beachdu/application/presentation/screens/product/product_screen.dart';
import 'package:beachdu/application/presentation/screens/profile/profile_screen.dart';
import 'package:beachdu/application/presentation/screens/questions/after_question_checked/final_price_screen/final_price_screen.dart';
import 'package:beachdu/application/presentation/screens/questions/after_question_checked/product_preview_screen.dart';
import 'package:beachdu/application/presentation/screens/questions/questions_screen.dart';
import 'package:beachdu/application/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  Route onGenerateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.initial:
        return fadePageRoute(screen: const ScreenSplash());
      case Routes.bottomBar:
        return fadePageRoute(screen: ScreenBottomNavigation());
      case Routes.signInOrLogin:
        return fadePageRoute(screen: const ScreenLogin());
      case Routes.otpVerification:
        return fadePageRoute(screen: const OTPScreen());
      case Routes.homeScreen:
        return fadePageRoute(screen: const ScreenHome());
      case Routes.pickUpDetailScreen:
        return fadePageRoute(screen: const ScreenPickUp());
      case Routes.questions:
        return fadePageRoute(screen: const ScreenQuestions());
      case Routes.produtPreview:
        return noTrancitionRoute(screen: const ScreenProductPreview());
      case Routes.searchScreen:
        return fadePageRoute(screen: const ScreenProductSelection());
      case Routes.finalPriceScreen:
        return fadePageRoute(screen: const FinalPriceScreen());
      case Routes.profile:
        return fadePageRoute(screen: const ScreenProfile());
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
