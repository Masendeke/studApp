/*
*Student Numbers:224043099, 224014647, 224125791, 224081629, 224083089
*Student Names  : Masendeke Chiedza P, Mahlangu Phindile, Khunyeli Paballo, Ntlati Thembinkosi T, Tshabane Lonwabo
*Question : AuthWrapper 
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_application/viewmodel/auth_viewmodel.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

    if (authVM.isLoggedIn) {
      return Homescreen();
    }

    return LoginScreen();
  }
}