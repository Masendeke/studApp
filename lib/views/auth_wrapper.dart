import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_application/views/auth_viewmodel.dart';
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