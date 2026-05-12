//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_application/views/auth_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword =
      TextEditingController();

  bool obscurePassword = true;

  bool obscureConfirm = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

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
            padding:
                const EdgeInsets.symmetric(horizontal: 25),

            child: Column(
              children: [

                // Register form

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
                          "Register",

                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Text(
                          "Create your student assistant account",

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 35),

                        // Email

                        TextFormField(
                          controller: email,

                          decoration: InputDecoration(
                            labelText: "University Email",

                            hintText:
                                "22404099@stud.cut.ac.za",

                            prefixIcon:
                                const Icon(Icons.email_outlined),

                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return "Email is required";
                            }

                            if (!value.contains('@')) {
                              return "Enter valid email";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Password

                        TextFormField(
                          controller: password,
                          obscureText: obscurePassword,

                          decoration: InputDecoration(
                            labelText: "Password",

                            hintText: "Enter password",

                            prefixIcon:
                                const Icon(Icons.lock_outline),

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

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return "Password is required";
                            }

                            if (value.length < 6) {
                              return "Minimum 6 characters";
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // Confirm password

                        TextFormField(
                          controller: confirmPassword,
                          obscureText: obscureConfirm,

                          decoration: InputDecoration(
                            labelText: "Confirm Password",

                            hintText: "Re-enter password",

                            prefixIcon:
                                const Icon(Icons.lock_outline),

                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureConfirm
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),

                              onPressed: () {
                                setState(() {
                                  obscureConfirm =
                                      !obscureConfirm;
                                });
                              },
                            ),

                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty) {
                              return "Confirm password";
                            }

                            if (value != password.text) {
                              return "Passwords do not match";
                            }

                            return null;
                          },
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

                        // Register button

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
                                              .signUp(
                                                email.text
                                                    .trim(),
                                                password.text
                                                    .trim(),
                                              );

                                      if (!context.mounted) {
                                        return;
                                      }

                                      if (success) {
                                        ScaffoldMessenger.of(
                                                context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Account created successfully",
                                            ),
                                          ),
                                        );

                                        Navigator.pop(
                                            context);
                                      }
                                    }
                                  },

                            child: authVM.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Create Account",

                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
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