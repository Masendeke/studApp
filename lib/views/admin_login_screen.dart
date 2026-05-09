//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081442 Nlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'admin_dashboard_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() =>
      _AdminLoginScreenState();
}

class _AdminLoginScreenState
    extends State<AdminLoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController email =
      TextEditingController();

  final TextEditingController password =
      TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  // ADMIN LOGIN METHOD
  void adminLogin() {

    // SAMPLE ADMIN DETAILS
    const adminEmail = "admin@cut.ac.za";
    const adminPassword = "admin123";

    if (email.text == adminEmail &&
        password.text == adminPassword) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const Admindashboardscreen(),
        ),
      );

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Access denied! You are not an admin.",
          ),
        ),
      );
    }
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

              Color(0xFF0B1F8F),
              Color(0xFF1976D2),
              Colors.white,
            ],
          ),
        ),

        child: Center(

          child: SingleChildScrollView(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 25,
            ),

            child: Column(

              children: [

                // LOGO + TITLE
                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    SizedBox(

                      height: 75,
                      width: 75,

                      child: CircleAvatar(

                        child: ClipOval(

                          child: Image.asset(

                            "assets/logo.png",

                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(

                          "Development",

                          style: TextStyle(

                            color: Colors.white,
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        Text(

                          "Crew",

                          style: TextStyle(

                            color: Colors.white,
                            fontSize: 38,
                            fontWeight:
                                FontWeight.bold,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 45),

                // LOGIN CONTAINER
                Form(

                  key: _formKey,

                  child: Container(

                    width: 380,

                    padding:
                        const EdgeInsets.all(25),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(25),

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

                          "Admin Login",

                          style: TextStyle(

                            fontSize: 35,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(

                          "Please login to continue to the admin dashboard",

                          textAlign: TextAlign.center,

                          style: TextStyle(

                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 35),

                        // EMAIL
                        TextFormField(

                          controller: email,

                          validator: (value) {

                            if (value == null ||
                                value.isEmpty) {

                              return "Enter admin email";
                            }

                            return null;
                          },

                          decoration: InputDecoration(

                            hintText:
                                "admin@cut.ac.za",

                            labelText:
                                "Admin Email",

                            prefixIcon: const Icon(
                              Icons.email_outlined,
                            ),

                            contentPadding:
                                const EdgeInsets
                                    .symmetric(

                              vertical: 18,
                              horizontal: 15,
                            ),

                            border:
                                OutlineInputBorder(

                              borderRadius:
                                  BorderRadius
                                      .circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // PASSWORD
                        TextFormField(

                          controller: password,

                          obscureText:
                              obscurePassword,

                          validator: (value) {

                            if (value == null ||
                                value.isEmpty) {

                              return "Enter password";
                            }

                            return null;
                          },

                          decoration: InputDecoration(

                            hintText:
                                "Enter password",

                            labelText:
                                "Password",

                            prefixIcon: const Icon(
                              Icons.lock_outline,
                            ),

                            contentPadding:
                                const EdgeInsets
                                    .symmetric(

                              vertical: 18,
                              horizontal: 15,
                            ),

                            suffixIcon:
                                IconButton(

                              icon: Icon(

                                obscurePassword

                                    ? Icons
                                        .visibility_off

                                    : Icons
                                        .visibility,
                              ),

                              onPressed: () {

                                setState(() {

                                  obscurePassword =
                                      !obscurePassword;
                                });
                              },
                            ),

                            border:
                                OutlineInputBorder(

                              borderRadius:
                                  BorderRadius
                                      .circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // LOGIN BUTTON
                        SizedBox(

                          width: double.infinity,
                          height: 50,

                          child: ElevatedButton(

                            style:
                                ElevatedButton
                                    .styleFrom(

                              backgroundColor:
                                  const Color(
                                      0xFF0B1F8F),

                              shape:
                                  RoundedRectangleBorder(

                                borderRadius:
                                    BorderRadius
                                        .circular(12),
                              ),
                            ),

                            onPressed: () {

                              if (_formKey
                                  .currentState!
                                  .validate()) {

                                adminLogin();
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