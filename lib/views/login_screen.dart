import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_application/routes/app_routes.dart';
import 'package:student_assistant_application/viewmodel/viewmodel.dart';

class LoginScreen extends StatelessWidget {
  // Form key validates all fields together
  final _formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers store typed text
    final email = TextEditingController();
    final password = TextEditingController();

    return Scaffold(
      body: Center(
        // Center puts UI in middle of screen
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo icon from UI
                const Icon(
                  Icons.shield_outlined,
                  size: 80,
                  color: Colors.blue,
                ),

                const SizedBox(height: 15),

                // Welcome text
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Please sign in to your university account",
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 30),

                // EMAIL FIELD
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: 'University Email',
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }

                    if (!value.contains('@')) {
                      return 'Enter valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // PASSWORD FIELD
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }

                    if (value.length < 6) {
                      return 'Minimum 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                Consumer<AuthViewModel>(
                  builder: (context, vm, child) {
                    return SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () async {
                          // Validate all fields first
                          if (_formKey.currentState!.validate()) {
                            await context.read<AuthViewModel>().login(
                                  email.text,
                                  password.text,
                                );

                            // Navigate after login
                           if (context.mounted) {
                           Navigator.pushNamed(
                            context,
                            AppRoutes.home,
                           );
                           }
                          }
                        },

                        child: Text(
                          vm.loading ? 'Loading....' : 'Login',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}