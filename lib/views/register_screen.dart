import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 10, 61, 145),
      leading:IconButton( icon: const Icon(Icons.arrow_back,color: Colors.white,),
      onPressed: (){
        Navigator.pop(context);
      },)
      ),
      body: Container(

        width: double.infinity,
        height: double.infinity,

        // SAME LOGIN BACKGROUND GRADIENT
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

                  // SAME CARD SIZE AS LOGIN
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

                          // EMAIL
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                              labelText: "University Email",
                              hintText: "22404099@stud.cut.ac.za",
                              prefixIcon: const Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Email is required";
                              }
                              if (!value.contains('@')) {
                                return "Enter valid email";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // PASSWORD
                          TextFormField(
                            controller: password,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              labelText: "Password",
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
                                return "Password is required";
                              }
                              if (value.length < 6) {
                                return "Minimum 6 characters";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // CONFIRM PASSWORD
                          TextFormField(
                            controller: confirmPassword,
                            obscureText: obscureConfirm,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              hintText: "Re-enter password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureConfirm
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscureConfirm = !obscureConfirm;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Confirm password";
                              }
                              if (value != password.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 24),

                          // REGISTER BUTTON
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 10, 61, 145),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),

                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // register logic
                                }
                              },

                              child: const Text(
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
      ),
    );
  }
}