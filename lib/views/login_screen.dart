import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_application/routes/app_routes.dart';
import 'package:student_assistant_application/viewmodel/viewmodel.dart';
import 'register_screen.dart';
import 'reset_password_screen.dart';

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
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 10, 61, 145),
              Color(0xFF566176),
              Color(0xFFD9D9D9),
            ],
          ),
        ),

        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),

              child: Column(
                children: [

                  // HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 75,
                        width: 75,
                        child: CircleAvatar(
                          child: ClipOval(
                            child: Image.asset("assets/logo.png",
                            fit: BoxFit.cover,
                            ))),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DEVELOPMENT",
                            style: TextStyle(
                            color: Colors.white,
                            fontSize:15,
                            fontWeight:FontWeight.bold,
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

                  // LOGIN FORM
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
                            "Please login in to your account",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 35),

                          // EMAIL
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
                              prefixIcon: const Icon(Icons.email_outlined),
                             contentPadding: const EdgeInsets.symmetric(
                             vertical: 18,
                             horizontal: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),

                          // FORGOT PASSWORD
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
                                  color: Color.fromARGB(255, 10, 61, 145),
                                ),
                              ),
                            ),
                          ),

                          // PASSWORD
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
                              prefixIcon: const Icon(Icons.lock_outline),
                              contentPadding: const EdgeInsets.symmetric(
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
                                    obscurePassword = !obscurePassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // LOGIN BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 10, 61, 145),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
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

                                  if (!context.mounted) return;

                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.home,
                                  );
                                }
                              },

                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // REGISTER LINK (FIXED ✔ BLUE + CLICKABLE)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                    color: Color.fromARGB(255, 10, 61, 145),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
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
      ),
    );
  }
}