//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import '../model/model.dart';
import '../viewmodel/viewmodel.dart';
import 'detail_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  final TextEditingController supportingDocument = TextEditingController();

  String? selectedYear;

  String? module1Level;
  String? module1Name;

  String? module2Level;
  String? module2Name;

  bool secondModuleEnabled = false;
  String? selectedFileName;

  bool eligibilityConfirmed = false;
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.pickFiles();

    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
      });
    }
  }

  final List<String> years = ['First Year', 'Second Year', 'Third Year'];

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
    supportingDocument.dispose();

    super.dispose();
  }

  // Input decoration

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

      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),

        borderSide: const BorderSide(color: Color(0xFF0B1F8F), width: 2),
      ),
    );
  }

  // Dropdown field

  Widget buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,

      decoration: buildInputDecoration(label: label),

      items: items.map((item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),

      onChanged: onChanged,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StudentViewModel>();

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
                // Personal info
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
                    hint: 'Enter student number',
                    icon: Icons.badge,
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Student number is required';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: name,

                  decoration: buildInputDecoration(
                    label: 'First Name',
                    hint: 'Enter first name',
                    icon: Icons.person,
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name is required';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: surname,

                  decoration: buildInputDecoration(
                    label: 'Surname',
                    hint: 'Enter surname',
                    icon: Icons.person_outline,
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Surname is required';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: email,

                  keyboardType: TextInputType.emailAddress,

                  decoration: buildInputDecoration(
                    label: 'Email Address',
                    hint: 'Enter email address',
                    icon: Icons.email,
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

                const SizedBox(height: 18),

                TextFormField(
                  controller: phone,

                  keyboardType: TextInputType.phone,

                  decoration: buildInputDecoration(
                    label: 'Phone Number',
                    hint: 'Enter phone number',
                    icon: Icons.phone,
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: course,

                  decoration: buildInputDecoration(
                    label: 'Course / Qualification',
                    hint: 'Enter course',
                    icon: Icons.school,
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Course is required';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Academic info
                const Text(
                  'Academic Information',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                buildDropdownField(
                  label: 'Current Year of Study',

                  value: selectedYear,

                  items: years,

                  onChanged: (value) {
                    setState(() {
                      selectedYear = value;
                    });
                  },
                ),

                const SizedBox(height: 30),

                // Module 1
                const Text(
                  'Module Application 1',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                buildDropdownField(
                  label: 'Academic Level',

                  value: module1Level,

                  items: academicLevels,

                  onChanged: (value) {
                    setState(() {
                      module1Level = value;
                      module1Name = null;
                    });
                  },
                ),

                const SizedBox(height: 18),

                if (module1Level != null)
                  buildDropdownField(
                    label: 'Module',

                    value: module1Name,

                    items: modulesByLevel[module1Level] ?? [],

                    onChanged: (value) {
                      setState(() {
                        module1Name = value;
                      });
                    },
                  ),

                const SizedBox(height: 25),

                // Second module checkbox
                CheckboxListTile(
                  activeColor: const Color(0xFF0B1F8F),

                  title: const Text(
                    'Apply for a second module',

                    style: TextStyle(color: Colors.white),
                  ),

                  value: secondModuleEnabled,

                  onChanged: (value) {
                    setState(() {
                      secondModuleEnabled = value ?? false;
                    });
                  },
                ),

                // Module 2
                if (secondModuleEnabled) ...[
                  const SizedBox(height: 18),

                  const Text(
                    'Module Application 2',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  buildDropdownField(
                    label: 'Academic Level',

                    value: module2Level,

                    items: academicLevels,

                    onChanged: (value) {
                      setState(() {
                        module2Level = value;
                        module2Name = null;
                      });
                    },
                  ),

                  const SizedBox(height: 18),

                  if (module2Level != null)
                    buildDropdownField(
                      label: 'Module',

                      value: module2Name,

                      items: modulesByLevel[module2Level] ?? [],

                      onChanged: (value) {
                        setState(() {
                          module2Name = value;
                        });
                      },
                    ),
                ],

               Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 12,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Row(
                    children: [
                      const Icon(Icons.upload_file, color: Color(0xFF0B1F8F)),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Text(
                          selectedFileName ?? "Upload Supporting Document",

                          style: TextStyle(
                            fontSize: 15,

                            color: selectedFileName == null
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                      ),

                      ElevatedButton(
                        onPressed: pickFile,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0B1F8F),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        child: const Text(
                          "Choose",

                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ), 
                const SizedBox(height: 18),

                // Eligibility
                CheckboxListTile(
                  activeColor: const Color(0xFF0B1F8F),

                  title: const Text(
                    'I confirm that I meet the eligibility requirements',

                    style: TextStyle(color: Colors.white),
                  ),

                  value: eligibilityConfirmed,

                  onChanged: (value) {
                    setState(() {
                      eligibilityConfirmed = value ?? false;
                    });
                  },
                ),

                const SizedBox(height: 30),

                // Error message
                if (vm.errorMessage != null)
                  Center(
                    child: Text(
                      vm.errorMessage!,

                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                const SizedBox(height: 15),

                const SizedBox(height: 20),

                // Submit button
             const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B1F8F),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),

                    onPressed: vm.isLoading
                        ? null
                        : () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            if (!eligibilityConfirmed) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please confirm eligibility"),
                                ),
                              );

                              return;
                            }

                            if (selectedFileName == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please upload a document"),
                                ),
                              );

                              return;
                            }

                            final student = StudentApplication(
                              id: const Uuid().v4(),
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

                            final success = await vm.addStudent(student);

                            if (!context.mounted) {
                              return;
                            }

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Application submitted successfully',
                                  ),
                                ),
                              );

                              Navigator.pushReplacement(
                                context,

                                MaterialPageRoute(
                                  builder: (_) =>
                                      DetailScreen(application: student),
                                ),
                              );
                            }
                          },

                    child: vm.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Submit Application',

                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
