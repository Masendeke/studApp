//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_application/views/admin_login_screen.dart';
import 'package:student_assistant_application/viewmodel/auth_viewmodel.dart';
import 'package:student_assistant_application/views/home_screen.dart';
import 'package:student_assistant_application/views/register_screen.dart';
import 'package:student_assistant_application/views/reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B1F8F),
              Color(0xFF1976D2),
              Colors.white,
            ],
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),

            child: Column(
              children: [

                // Header

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      image: const DecorationImage(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),


                    const SizedBox(width: 12),

                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "DEVELOPMENT",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "CREW",

                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 45),

                // Login form

                Form(
                  key: _formKey,

                  child: Container(
                    width: 380,
                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),

                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),

                    child: Column(
                      children: [

                        const Text(
                          "Welcome",

                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Text(
                          "Please login to your student assistant account",

                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 35),

                        // Email

                        TextFormField(
                          controller: email,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter email";
                            }

                            return null;
                          },

                          decoration: InputDecoration(
                            hintText: "22404099@stud.cut.ac.za",
                            labelText: "University email",

                            prefixIcon:
                                const Icon(Icons.email_outlined),

                            contentPadding:
                                const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 15,
                            ),

                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        // Forgot password

                        Align(
                          alignment: Alignment.centerRight,

                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const ResetPasswordScreen(),
                                ),
                              );
                            },

                            child: const Text(
                              "Forgot Password?",

                              style: TextStyle(
                                color: Color(0xFF0B1F8F),
                              ),
                            ),
                          ),
                        ),

                        // Password

                        TextFormField(
                          controller: password,
                          obscureText: obscurePassword,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            }

                            return null;
                          },

                          decoration: InputDecoration(
                            hintText: "Enter password",
                            labelText: "Password",

                            prefixIcon:
                                const Icon(Icons.lock_outline),

                            contentPadding:
                                const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 15,
                            ),

                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),

                              onPressed: () {
                                setState(() {
                                  obscurePassword =
                                      !obscurePassword;
                                });
                              },
                            ),

                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Error message

                        if (authVM.errorMessage != null)
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10),

                            child: Text(
                              authVM.errorMessage!,

                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                            ),
                          ),

                        const SizedBox(height: 24),

                        // Login button

                        SizedBox(
                          width: double.infinity,
                          height: 50,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF0B1F8F),

                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),

                            onPressed: authVM.isLoading
                                ? null
                                : () async {
                                    if (_formKey.currentState!
                                        .validate()) {

                                      final success =
                                          await context
                                              .read<AuthViewModel>()
                                              .signIn(
                                                email.text.trim(),
                                                password.text.trim(),
                                              );

                                      if (!context.mounted) return;

                                      if (success) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const Homescreen(),
                                          ),
                                        );
                                      }
                                    }
                                  },

                            child: authVM.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Login",

                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Admin login button

                        SizedBox(
                          width: double.infinity,
                          height: 50,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF0B1F8F),

                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const AdminLoginScreen(),
                                ),
                              );
                            },

                            child: const Text(
                              "Admin Login",

                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Register link

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,

                          children: [
                            const Text(
                              "Don't have an account? ",

                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },

                              child: const Text(
                                "Register",

                                style: TextStyle(
                                  color: Color(0xFF0B1F8F),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration:
                                      TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}