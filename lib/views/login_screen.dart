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
             crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo icon from UI
                 Align(
            alignment: Alignment.topRight,
             
                // Welcome text
                child:Container(
                   margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset('assets/logo.png',
             height: 35,
             width: 35,
             fit: BoxFit.contain,
             ),
            ),
          ),

                const SizedBox(height: 15),
                 const Text(
            "University IT Assistant",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ), // end Text
                const Text(
            "Secure portal for student assistant\napplications and management",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 35),
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
                    children: [
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
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // EMAIL FIELD
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
                  
                  // PASSWORD FIELD
                  StatefulBuilder(
                    builder: (context, setState) {
                      bool obscurePassword =true;

                      return TextFormField(
                        controller: password,
                        obscureText: obscurePassword,
                      
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: "Enter password",
                          
                           prefixIcon: const Icon(
                            Icons.lock_outline,
                            ),
                          suffixIcon: IconButton(
                            icon: Icon(
                           obscurePassword? Icons.visibility_off
                           // ignore: dead_code
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
                      );
                    }
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Consumer<AuthViewModel>(
                    builder: (context, vm, child) {
                      return SizedBox(
                        width: double.infinity,
                  
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                         BorderRadius.circular(12),
                         ),
                          ), 
                  
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
                            vm.loading ? 'Loading...' : 'Login',style: TextStyle(fontSize: 18,color: Colors.white,),
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