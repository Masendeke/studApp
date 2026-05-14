//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../viewmodel/viewmodel.dart';
import '../model/model.dart';
import 'detail_screen.dart';

class Applicationformscreen extends StatefulWidget {
  const Applicationformscreen({super.key});

  @override
  State<Applicationformscreen> createState() => _ApplicationformscreenState();
}

class _ApplicationformscreenState extends State<Applicationformscreen> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController stdNo = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController surname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController course = TextEditingController();
  final TextEditingController module1 = TextEditingController();
  final TextEditingController module2 = TextEditingController();
  
  String? selectedYear;
  bool eligibilityConfirmed = false;
  bool isSubmitting = false;

  final List<String> years = ['First Year', 'Second Year', 'Third Year'];

  @override
  void dispose() {
    stdNo.dispose();
    name.dispose();
    surname.dispose();
    email.dispose();
    phone.dispose();
    course.dispose();
    module1.dispose();
    module2.dispose();
    super.dispose();
  }

  // ✅ Validation helper methods
  String? validateStudentNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Student number is required';
    }
    if (value.length == 8 ) {
      return 'Student number must be 9 digits';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Student number must contain only numbers';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!value.contains('@')) {
      return 'Enter a valid email address';
    }
    if (!value.contains('.') || value.length < 5) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Phone number must be at least 10 digits';
    }
    if (!RegExp(r'^[0-9+\s\-]+$').hasMatch(value)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validateCourse(String? value) {
    if (value == null || value.isEmpty) {
      return 'Course is required';
    }
    if (value.length < 2) {
      return 'Enter a valid course name';
    }
    return null;
  }

  String? validateModule(String? value) {
    if (value == null || value.isEmpty) {
      return 'Module is required';
    }
    if (value.length < 2) {
      return 'Enter a valid module code';
    }
    return null;
  }

  Future<void> submitApplication() async {
    // ✅ Check form validation first
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    if (!eligibilityConfirmed) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please confirm eligibility")),
        );
      }
      return;
    }
    
    if (selectedYear == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select year of study")),
        );
      }
      return;
    }

    setState(() => isSubmitting = true);

    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please login first")),
        );
      }
      setState(() => isSubmitting = false);
      return;
    }

    final student = StudentApplication(
      id: null,
      userId: user.id,
      stdNo: stdNo.text.trim(),
      name: name.text.trim(),
      surname: surname.text.trim(),
      email: email.text.trim(),
      phone: phone.text.trim(),
      course: course.text.trim(),
      yearOfStudy: selectedYear!,
      module1: module1.text.trim(),
      module2: module2.text.trim(),
      status: 'Pending',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final vm = context.read<StudentViewModel>();
    final success = await vm.addStudent(student);

    setState(() => isSubmitting = false);

    if (!mounted) return;

    if (success) {
      // ✅ Refresh only current user's data
      final userId = Supabase.instance.client.auth.currentUser?.id;
      if (userId != null) {
        await vm.fetchUserStudents(userId);
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Application submitted successfully!")),
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DetailScreen(application: student)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(vm.errorMessage ?? "Submission failed")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),
        title: const Text('Application Form', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B1F8F), Color(0xFF1976D2), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Personal Information', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                
                // Student Number
                TextFormField(
                  controller: stdNo,
                  decoration: _inputDecoration('Student Number', Icons.badge),
                  validator: validateStudentNumber,
                ),
                const SizedBox(height: 15),
                
                // First Name
                TextFormField(
                  controller: name,
                  decoration: _inputDecoration('First Name', Icons.person),
                  validator: validateName,
                ),
                const SizedBox(height: 15),
                
                // Surname
                TextFormField(
                  controller: surname,
                  decoration: _inputDecoration('Surname', Icons.person_outline),
                  validator: validateName,
                ),
                const SizedBox(height: 15),
                
                // Email
                TextFormField(
                  controller: email,
                  decoration: _inputDecoration('Email', Icons.email),
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                
                // Phone
                TextFormField(
                  controller: phone,
                  decoration: _inputDecoration('Phone', Icons.phone),
                  validator: validatePhone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 15),
                
                // Course
                TextFormField(
                  controller: course,
                  decoration: _inputDecoration('Course', Icons.school),
                  validator: validateCourse,
                ),
                const SizedBox(height: 25),
                
                const Text('Academic Information', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                
                // Year of Study (Dropdown)
                DropdownButtonFormField<String>(
                  value: selectedYear,
                  decoration: _inputDecoration('Year of Study', Icons.calendar_today),
                  items: years.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
                  onChanged: (v) => setState(() => selectedYear = v),
                  validator: (v) => v == null ? 'Please select year of study' : null,
                ),
                const SizedBox(height: 15),
                
                // Module 1
                TextFormField(
                  controller: module1,
                  decoration: _inputDecoration('Module 1', Icons.book),
                  validator: validateModule,
                ),
                const SizedBox(height: 15),
                
                // Module 2 (Optional - different validator)
                TextFormField(
                  controller: module2,
                  decoration: _inputDecoration('Module 2 (Optional)', Icons.menu_book),
                  // No validator - optional field
                ),
                const SizedBox(height: 20),
                
                // Eligibility Checkbox
                CheckboxListTile(
                  activeColor: const Color(0xFF0B1F8F),
                  value: eligibilityConfirmed,
                  onChanged: (v) => setState(() => eligibilityConfirmed = v ?? false),
                  title: const Text('I confirm eligibility', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 20),
                
                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B1F8F),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: isSubmitting ? null : submitApplication,
                    child: isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Submit Application', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}