//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';

import 'package:student_assistant_application/views/admin_login_screen.dart';
import 'package:student_assistant_application/views/register_screen.dart';
import 'package:student_assistant_application/views/reset_password_screen.dart';
import 'package:student_assistant_application/views/admin_dashboard_screen.dart';
import 'package:student_assistant_application/views/application_form_screen.dart';
import 'package:student_assistant_application/views/home_screen.dart';
import 'package:student_assistant_application/views/login_screen.dart';

import 'package:student_assistant_application/views/detail_screen.dart'
    as detail;

import 'package:student_assistant_application/model/model.dart';

class AppRoutes {

  static const String login = '/';
  static const String home = '/home';
  static const String apply = '/apply';
  static const String details = '/details';
  static const String admin = '/admin';
  static const String resetpassword = '/resetpassword';
  static const String register = '/register';
  static const String adminlogin = '/adminlogin';

  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => Homescreen(),
        );

      case apply:
        return MaterialPageRoute(
          builder: (_) => const Applicationformscreen(),
        );

      // ✅ FIXED HERE
      case details:
        final student =
            settings.arguments as StudentApplication;

        return MaterialPageRoute(
          builder: (_) => detail.DetailScreen(
            application: student,
          ),
        );

      case admin:
        return MaterialPageRoute(
          builder: (_) => Admindashboardscreen(),
        );

      case resetpassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );

      case register:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );

      case adminlogin:
        return MaterialPageRoute(
          builder: (_) => AdminLoginScreen(),
        );

      default:
        throw Exception('Route not found');
    }
  }
}