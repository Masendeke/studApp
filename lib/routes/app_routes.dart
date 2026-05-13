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

class AppRoutes {//this class is used to manage the routes of the application and also to pass the arguments to the details screen

  static const String login = '/';//used for the login screen route and also added in the main.dart for the initial route
  static const String home = '/home';//used for the home screen route and also added in the login screen for the login button
  static const String apply = '/apply';//used for the application form screen route and also added in the home screen for the apply button
  static const String details = '/details';//used for the details screen route and also added in the home screen for the details button
  static const String admin = '/admin';//used for the admin dashboard screen route
  static const String resetpassword = '/resetpassword';//used for the reset password screen route
  static const String register = '/register';//used for the registration screen route
  static const String adminlogin = '/adminlogin';//used for the admin login screen route
   static const String editApplication = '/editApplication';//also added in the details screen for the edit button and used as manage button //used for the edit application screen route

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //used to generate the routes of the application and also to pass the arguments to the details screen

    switch (settings.name) {
      //used to switch between the routes of the application and also to pass the arguments to the details screen

      case login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );//used for the login screen route and also added in the main.dart for the initial route

      case home:
        return MaterialPageRoute(
          builder: (_) => Homescreen(),
        );//used for the home screen route and also added in the login screen for the login button

      case apply:
        return MaterialPageRoute(
          builder: (_) => const Applicationformscreen(),
<<<<<<< HEAD
        );
    
=======
        );//used for the application form screen route and also added in the home screen for the apply button

      // ✅ FIXED HERE
>>>>>>> main
      case details:
        final student =
            settings.arguments as StudentApplication;
            // Ensure that the argument is of the correct type and not null

        return MaterialPageRoute(
          builder: (_) => detail.DetailScreen(
            application: student,
          ),
        );//used for the details screen route and also added in the home screen for the details button

      case admin:
        return MaterialPageRoute(
          builder: (_) => Admindashboardscreen(),
        );//used for the admin dashboard screen route

      case resetpassword:
        return MaterialPageRoute(
          builder: (_) => const ResetPasswordScreen(),
        );//used for the reset password screen route

      case register:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );//used for the registration screen route

      case adminlogin:
        return MaterialPageRoute(
          builder: (_) => AdminLoginScreen(),
        );//used for the admin login screen route

      default:
        throw Exception('Route not found');
    }//used to throw an exception if the route is not found
  }
}