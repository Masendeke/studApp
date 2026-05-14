//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/model.dart';
import '../viewmodel/viewmodel.dart';
import 'detail_screen.dart';

class Applicationformscreen extends StatefulWidget {
  const Applicationformscreen({super.key});

  @override
  State<Applicationformscreen> createState() =>
      _ApplicationformscreenState();
}

class _ApplicationformscreenState extends State<Applicationformscreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController stdNo = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController surname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController course = TextEditingController();

  String? selectedYear;

  String? module1Level;
  String? module1Name;

  String? module2Level;
  String? module2Name;

  bool secondModuleEnabled = false;
  String? selectedFileName;
  bool eligibilityConfirmed = false;

  Future<void> pickFile() async {
    FilePickerResult? result =
        await FilePicker.pickFiles();

    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
      });
    }
  }

  final List<String> years = [
    'First Year',
    'Second Year',
    'Third Year'
  ];

  final List<String> academicLevels = [
    'First Year',
    'Second Year',
    'Third Year',
  ];

  final Map<String, List<String>> modulesByLevel = {
    'First Year': ['ICT101', 'TPG111', 'MAT101'],
    'Second Year': ['TPG211', 'DBS210', 'WPR221'],
    'Third Year': ['TPG316C', 'PRJ300', 'SEC310'],
  };

  @override
  void dispose() {
    stdNo.dispose();
    name.dispose();
    surname.dispose();
    email.dispose();
    phone.dispose();
    course.dispose();
    super.dispose();
  }

  InputDecoration buildInputDecoration({
    required String label,
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon != null ? Icon(icon) : null,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide:
            const BorderSide(color: Color(0xFF0B1F8F), width: 2),
      ),
    );
  }

  Widget buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      // ignore: deprecated_member_use
      value: value,
      decoration: buildInputDecoration(label: label),
      items: items
          .map((item) =>
              DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StudentViewModel>();
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),
        title: const Text(
          'Student Assistant Application Form',
          style: TextStyle(color: Colors.white),
        ),
       leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B1F8F),
              Color(0xFF1976D2),
              Colors.white
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Personal Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: stdNo,
                  decoration: buildInputDecoration(
                    label: 'Student Number',
                    icon: Icons.badge,
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: name,
                  decoration: buildInputDecoration(
                    label: 'First Name',
                    icon: Icons.person,
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: surname,
                  decoration: buildInputDecoration(
                    label: 'Surname',
                    icon: Icons.person_outline,
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: email,
                  decoration: buildInputDecoration(
                    label: 'Email',
                    icon: Icons.email,
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: phone,
                  decoration: buildInputDecoration(
                    label: 'Phone',
                    icon: Icons.phone,
                  ),
                ),

                const SizedBox(height: 15),

                TextFormField(
                  controller: course,
                  decoration: buildInputDecoration(
                    label: 'Course',
                    icon: Icons.school,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'Academic Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                buildDropdownField(
                  label: 'Year of Study',
                  value: selectedYear,
                  items: years,
                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                ),

                const SizedBox(height: 20),
            
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.upload_file,
                      color: Color(0xFF0B1F8F),
                    ),
                    title: Text(
                      selectedFileName ?? "No file selected",
                    ),
                    trailing: ElevatedButton(
                      onPressed: pickFile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B1F8F),
                      ),
                      child: const Text("Upload"),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                CheckboxListTile(
                  activeColor: const Color(0xFF0B1F8F),
                  value: eligibilityConfirmed,
                  onChanged: (value) {
                    setState(() {
                      eligibilityConfirmed = value ?? false;
                    });
                  },
                  title: const Text(
                    'I confirm eligibility',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B1F8F),
                    ),
                    onPressed: vm.isLoading
                        ? null
                        : () async {
                            if (user == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text("User not logged in"),
                                ),
                              );
                              return;
                            }

                            if (!_formKey.currentState!.validate()) {
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
                              yearOfStudy: selectedYear ?? '',
                              module1: module1Name ?? '',
                              module2: module2Name ?? '',
                              status: 'Pending',
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );

                            final success =
                                await vm.addStudent(student);

                            if (!context.mounted) return;

                            if (success) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailScreen(application: student),
                                ),
                              );
                            }
                          },
                    child: const Text(
                      "Submit Application",
                      style: TextStyle(color: Colors.white),
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