/*
*Student Numbers:224043099, 224014647, 224125791, 224081629, 224083089
*Student Names  : Masendeke Chiedza P, Mahlangu Phindile, Khunyeli Paballo, Ntlati Thembinkosi T, Tshabane Lonwabo
*Question : Resetpasswordscreen
*/

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController newPassword =
      TextEditingController();

  final TextEditingController confirmPassword =
      TextEditingController();

  bool obscure1 = true;
  bool obscure2 = true;

  bool isLoading = false;

  @override
  void dispose() {
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  // RESET PASSWORD FUNCTION
  Future<void> resetPassword() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      await Supabase.instance.client.auth.updateUser(

        UserAttributes(
          password: newPassword.text.trim(),
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            "Password changed successfully",
          ),
        ),
      );

      // GO BACK TO LOGIN SCREEN
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (route) => false,
      );

    } on AuthException catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(e.message),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(
          content: Text(
            "Error: $e",
          ),
        ),
      );

    } finally {

      if (mounted) {

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor:
            const Color(0xFF0B1F8F),

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(

          "Reset Password",

          style: TextStyle(
            color: Colors.white,
          ),
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

        child: SafeArea(

          child: Center(

            child: SingleChildScrollView(

              padding:
                  const EdgeInsets.symmetric(
                horizontal: 25,
              ),

              child: Column(

                children: [

                  Form(

                    key: _formKey,

                    child: Container(

                      width: 380,

                      padding:
                          const EdgeInsets.all(25),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(
                                25),

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

                            "Reset Password",

                            style: TextStyle(

                              fontSize: 38,

                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(

                            "Enter your new password below",

                            textAlign:
                                TextAlign.center,

                            style: TextStyle(

                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 35),

                          // NEW PASSWORD
                          TextFormField(

                            controller:
                                newPassword,

                            obscureText: obscure1,

                            decoration:
                                InputDecoration(

                              labelText:
                                  "New Password",

                              prefixIcon:
                                  const Icon(
                                Icons.lock_outline,
                              ),

                              suffixIcon:
                                  IconButton(

                                icon: Icon(

                                  obscure1
                                      ? Icons
                                          .visibility_off
                                      : Icons
                                          .visibility,
                                ),

                                onPressed: () {

                                  setState(() {

                                    obscure1 =
                                        !obscure1;
                                  });
                                },
                              ),

                              border:
                                  OutlineInputBorder(

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            12),
                              ),
                            ),

                            validator: (value) {

                              if (value == null ||
                                  value.isEmpty) {

                                return
                                    "Enter new password";
                              }

                              if (value.length < 6) {

                                return
                                    "Minimum 6 characters";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // CONFIRM PASSWORD
                          TextFormField(

                            controller:
                                confirmPassword,

                            obscureText: obscure2,

                            decoration:
                                InputDecoration(

                              labelText:
                                  "Confirm Password",

                              prefixIcon:
                                  const Icon(
                                Icons.lock_outline,
                              ),

                              suffixIcon:
                                  IconButton(

                                icon: Icon(

                                  obscure2
                                      ? Icons
                                          .visibility_off
                                      : Icons
                                          .visibility,
                                ),

                                onPressed: () {

                                  setState(() {

                                    obscure2 =
                                        !obscure2;
                                  });
                                },
                              ),

                              border:
                                  OutlineInputBorder(

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            12),
                              ),
                            ),

                            validator: (value) {

                              if (value == null ||
                                  value.isEmpty) {

                                return
                                    "Confirm password";
                              }

                              if (value !=
                                  newPassword.text) {

                                return
                                    "Passwords do not match";
                              }

                              return null;
                            },
                          ),

                          const SizedBox(height: 24),

                          // RESET BUTTON
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
                                          .circular(
                                              12),
                                ),
                              ),

                              onPressed: isLoading
                                  ? null
                                  : resetPassword,

                              child: isLoading

                                  ? const CircularProgressIndicator(
                                      color:
                                          Colors.white,
                                    )

                                  : const Text(

                                      "Reset Password",

                                      style:
                                          TextStyle(

                                        fontSize: 20,
                                        color:
                                            Colors
                                                .white,
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