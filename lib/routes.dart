import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'jobseeker_screen.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'Home_Screen.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String jobseeker = '/jobseeker';
  static const String home = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => SplashScreenWidget(),
      login: (context) => LoginScreen(),
      signup: (context) => SignUpScreen(),
      jobseeker: (context) => JobSeekerScreen(),
      home: (context) =>
          HomeScreen(userName: "User"), // عدّليها لاحقاً بالبيانات
    };
  }
}
