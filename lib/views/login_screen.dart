import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_application/routes/app_routes.dart';
import 'package:student_assistant_application/viewmodel/viewmodel.dart';

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
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 231, 239),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // CIRCULAR LOGO (NO EXTRA SPACE)
                CircleAvatar(
                  radius: 90,
                  backgroundColor: const Color.fromARGB(255, 223, 231, 239),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                      width: 950,
                      height: 150,
                    ),
                  ),
                ),

                const Text(
                  "Secure portal for student assistant\napplications and management",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 30),

                // CARD CONTAINER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        color: Colors.black12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      const Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Please sign in to your university account",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),

                      const SizedBox(height: 30),

                      // EMAIL
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'University Email',
                          hintText: "e.g 2113@stud.cut.ac.za",
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                        onPressed: () {
                        // navigate to forgot password screen
                        },
                                             child: const Text(
                        
                                             "Forgot Password?",
                        style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 10, 61, 145),
                         ),
                        ),
                                            ),
                      ),

                      // PASSWORD
                      TextFormField(
                        controller: password,
                        obscureText: obscurePassword,

                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: "Enter password",
                          prefixIcon: const Icon(Icons.lock_outline),

                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
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

                      // LOGIN BUTTON
                      Consumer<AuthViewModel>(
                        builder: (context, vm, child) {
                          return SizedBox(
                            width: double.infinity,

                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(255, 10, 61, 145),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),

                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await context
                                      .read<AuthViewModel>()
                                      .login(
                                        email.text,
                                        password.text,
                                      );

                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.home,
                                    );
                                  }
                                }
                              },

                              child: Text(
                                vm.loading ? 'Loading...' : 'Login',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
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