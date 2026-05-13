//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {//This screen is used to reset the password of the user and also to update the password in the database, it contains two text fields for the new password and confirm password, and a button to reset the password
  final _formKey = GlobalKey<FormState>();// The _formKey is used to validate the form fields when the user clicks the reset button, ensuring that the new password and confirm password fields are filled out correctly before allowing the password reset process to proceed
// The newPassword and confirmPassword controllers are used to manage the input from the user for the new password and confirm password fields, allowing us to access the values entered by the user when validating the form and performing the password reset logic
  final TextEditingController newPassword =
      TextEditingController();
  final TextEditingController confirmPassword =
      TextEditingController();

  bool obscure1 = true;
  bool obscure2 = true;

  @override
  void dispose() {
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //  APP BAR WITH ARROW ONLY (NO BUTTON TEXT)
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Reset Password",
          style: TextStyle(color: Colors.white),
        ),
      ),

      //  SAME BACKGROUND AS REGISTER / LOGIN
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
              padding: const EdgeInsets.symmetric(horizontal: 25),

              child: Column(
                children: [

                  // ✅ SAME CARD SIZE AS LOGIN/REGISTER
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
                            "Reset Password",
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            "Enter your new password below",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 35),

                          // NEW PASSWORD
                          TextFormField(
                            controller: newPassword,
                            obscureText: obscure1,
                            decoration: InputDecoration(
                              labelText: "New Password",
                              prefixIcon:
                                  const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscure1
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscure1 = !obscure1;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter new password";
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
                            obscureText: obscure2,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              prefixIcon:
                                  const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscure2
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscure2 = !obscure2;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value != newPassword.text) {
                                return "Passwords do not match";
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF0B1F8F),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {// When the reset button is pressed, the form is validated using the _formKey. If the validation passes (i.e., the new password and confirm password fields are correctly filled out), the password reset logic can be executed, which may involve updating the password in the database and providing feedback to the user about the success of the operation
                                if (_formKey.currentState!
                                    .validate()) {
                                  // reset logic
                                }
                              },
                              child: const Text(
                                "Reset Password",
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