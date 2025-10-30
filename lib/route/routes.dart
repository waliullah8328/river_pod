

import 'package:flutter/material.dart';
import 'package:river_pod/features/nav_main/view/home_screen.dart';
import 'package:river_pod/features/language_selection_screen/language_selection_screen.dart';
import 'package:river_pod/features/authentication/login/view/login_screen.dart';
import 'package:river_pod/features/on_boarding/view/on_boarding_screen.dart';

import 'package:river_pod/route/routes_name.dart';

import '../features/authentication/sign_up/view/sign_up_screen.dart';
import '../features/splash_screen/view/splash_screen.dart';




class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){

      case RouteNames.splashScreen:
        return MaterialPageRoute(builder: (context)=>SplashScreen());
      case RouteNames.languageScreen:
        return MaterialPageRoute(builder: (context)=>LanguageScreen());
      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (context)=>HomeScreen1());
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (context)=>LoginScreen());

      case RouteNames.signUpScreen:
        return MaterialPageRoute(builder: (context)=>SignUpScreen());
      case RouteNames.onboardingScreen:
        return MaterialPageRoute(builder: (context)=>OnboardingScreen());
      default:
        return MaterialPageRoute(builder: (context){
          return Scaffold(body: Center(child: Text("No route generated"),),);
        });

    }

  }
}