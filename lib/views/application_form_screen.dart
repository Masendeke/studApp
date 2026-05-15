/*
*Student Numbers:224043099, 224014647, 224125791, 224081629, 224083089
*Student Names  : Masendeke Chiedza P, Mahlangu Phindile, Khunyeli Paballo,
*Ntlati Thembinkosi T, Tshabane Lonwabo
*Question : ApplicationFormScreen
*/

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_application/viewmodel/viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/model.dart';
import 'detail_screen.dart';

class Applicationformscreen extends StatefulWidget {
  const Applicationformscreen({super.key});

  @override
  State<Applicationformscreen> createState() =>
      _ApplicationformscreenState();
}

class _ApplicationformscreenState
    extends State<Applicationformscreen> {

  final _formKey = GlobalKey<FormState>();

  // CONTROLLERS
  final TextEditingController stdNo =
      TextEditingController();

  final TextEditingController name =
      TextEditingController();

  final TextEditingController surname =
      TextEditingController();

  final TextEditingController email =
      TextEditingController();

  final TextEditingController phone =
      TextEditingController();

  final TextEditingController course =
      TextEditingController();

  String? selectedYear;

  String? module1Level;
  String? module1Name;

  String? module2Level;
  String? module2Name;

  bool secondModuleEnabled = false;

  String? selectedFileName;

  bool eligibilityConfirmed = false;

  // FILE PICKER
  Future<void> pickFile() async {

    FilePickerResult? result =
        await FilePicker.platform.pickFiles();

    if (result != null) {

      setState(() {

        selectedFileName =
            result.files.single.name;
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

    'First Year': [
      'ICT101',
      'TPG111',
      'MAT101'
    ],

    'Second Year': [
      'TPG211',
      'DBS210',
      'WPR221'
    ],

    'Third Year': [
      'TPG316C',
      'PRJ300',
      'SEC310'
    ],
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

  // INPUT DECORATION
  InputDecoration buildInputDecoration({

    required String label,
    String? hint,
    IconData? icon,

  }) {

    return InputDecoration(

      labelText: label,
      hintText: hint,

      prefixIcon:
          icon != null ? Icon(icon) : null,

      filled: true,
      fillColor: Colors.white,

      contentPadding:
          const EdgeInsets.symmetric(

        vertical: 18,
        horizontal: 15,
      ),

      border: OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(15),

        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(15),

        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(15),

        borderSide: const BorderSide(
          color: Color(0xFF0B1F8F),
          width: 2,
        ),
      ),
    );
  }

  // DROPDOWN FIELD
  Widget buildDropdownField({

    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,

  }) {

    return DropdownButtonFormField<String>(

      // ignore: deprecated_member_use
      value: value,

      decoration:
          buildInputDecoration(label: label),

      items: items.map((item) {

        return DropdownMenuItem(

          value: item,
          child: Text(item),
        );

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

    return Scaffold(

      appBar: AppBar(

        backgroundColor:
            const Color(0xFF0B1F8F),

        title: const Text(

          'Student Assistant Application Form',

          style: TextStyle(
            color: Colors.white,
          ),
        ),

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),

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

          padding:
              const EdgeInsets.all(16),

          child: Form(

            key: _formKey,

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // PERSONAL INFO
                const Text(

                  'Personal Information',

                  style: TextStyle(

                    color: Colors.white,
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // STUDENT NUMBER
                TextFormField(

                  controller: stdNo,

                  decoration:
                      buildInputDecoration(

                    label: 'Student Number',
                    hint: 'Enter student number',
                    icon: Icons.badge,
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return
                          'Student number is required';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // NAME
                TextFormField(

                  controller: name,

                  decoration:
                      buildInputDecoration(

                    label: 'First Name',
                    hint: 'Enter first name',
                    icon: Icons.person,
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return
                          'First name is required';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // SURNAME
                TextFormField(

                  controller: surname,

                  decoration:
                      buildInputDecoration(

                    label: 'Surname',
                    hint: 'Enter surname',
                    icon: Icons.person_outline,
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return
                          'Surname is required';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // EMAIL
                TextFormField(

                  controller: email,

                  keyboardType:
                      TextInputType.emailAddress,

                  decoration:
                      buildInputDecoration(

                    label: 'Email Address',
                    hint: 'Enter email address',
                    icon: Icons.email,
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return 'Email is required';
                    }

                    if (!value.contains('@')) {

                      return
                          'Enter valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // PHONE
                TextFormField(

                  controller: phone,

                  keyboardType:
                      TextInputType.phone,

                  decoration:
                      buildInputDecoration(

                    label: 'Phone Number',
                    hint: 'Enter phone number',
                    icon: Icons.phone,
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return
                          'Phone number is required';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // COURSE
                TextFormField(

                  controller: course,

                  decoration:
                      buildInputDecoration(

                    label:
                        'Course / Qualification',

                    hint: 'Enter course',

                    icon: Icons.school,
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return
                          'Course is required';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // ACADEMIC INFO
                const Text(

                  'Academic Information',

                  style: TextStyle(

                    color: Colors.white,
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // YEAR OF STUDY
                buildDropdownField(

                  label:
                      'Current Year of Study',

                  value: selectedYear,

                  items: years,

                  onChanged: (value) {

                    setState(() {

                      selectedYear = value;
                    });
                  },
                ),

                const SizedBox(height: 30),

                // MODULE 1
                const Text(

                  'Module Application 1',

                  style: TextStyle(

                    color: Colors.white,
                    fontSize: 20,
                    fontWeight:
                        FontWeight.bold,
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

                    items:
                        modulesByLevel[
                                module1Level] ??
                            [],

                    onChanged: (value) {

                      setState(() {

                        module1Name = value;
                      });
                    },
                  ),

                const SizedBox(height: 25),

                // SECOND MODULE
                CheckboxListTile(

                  activeColor:
                      const Color(0xFF0B1F8F),

                  title: const Text(

                    'Apply for a second module',

                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  value:
                      secondModuleEnabled,

                  onChanged: (value) {

                    setState(() {

                      secondModuleEnabled =
                          value ?? false;
                    });
                  },
                ),

                // MODULE 2
                if (secondModuleEnabled) ...[

                  const SizedBox(height: 18),

                  const Text(

                    'Module Application 2',

                    style: TextStyle(

                      color: Colors.white,
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
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

                      items:
                          modulesByLevel[
                                  module2Level] ??
                              [],

                      onChanged: (value) {

                        setState(() {

                          module2Name = value;
                        });
                      },
                    ),
                ],

                const SizedBox(height: 25),

                // FILE PICKER
                Container(

                  padding:
                      const EdgeInsets.all(15),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                            12),
                  ),

                  child: Row(

                    children: [

                      const Icon(

                        Icons.upload_file,

                        color:
                            Color(0xFF0B1F8F),
                      ),

                      const SizedBox(width: 10),

                      Expanded(

                        child: Text(

                          selectedFileName ??
                              "No file selected",
                        ),
                      ),

                      ElevatedButton(

                        onPressed: pickFile,

                        style:
                            ElevatedButton
                                .styleFrom(

                          backgroundColor:
                              const Color(
                                  0xFF0B1F8F),
                        ),

                        child: const Text(

                          "Choose File",

                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // ELIGIBILITY
                CheckboxListTile(

                  activeColor:
                      const Color(0xFF0B1F8F),

                  title: const Text(

                    'I confirm that I meet the eligibility requirements',

                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  value:
                      eligibilityConfirmed,

                  onChanged: (value) {

                    setState(() {

                      eligibilityConfirmed =
                          value ?? false;
                    });
                  },
                ),

                const SizedBox(height: 25),

                // SUBMIT BUTTON
                SizedBox(

                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(

                    style:
                        ElevatedButton.styleFrom(

                      backgroundColor:
                          const Color(
                              0xFF0B1F8F),

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(
                                15),
                      ),
                    ),

                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

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

                      // Get current user
                      final user = Supabase.instance.client.auth.currentUser;
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please login first")),
                        );
                        return;
                      }

                      // Create student object with REAL data
                      final student = StudentApplication(
                        id: null,
                        userId: user.id, //  Real user ID
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

                      //  CALL THE VIEWMODEL TO SAVE TO DATABASE
                      final vm = context.read<StudentViewModel>();
                      final success = await vm.addStudent(student);

                      if (!mounted) return;

                      if (success) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Application submitted successfully!",
                            ),
                          ),
                        );

                        // Refresh the user's applications
                        final userId =
                            Supabase.instance.client.auth.currentUser?.id;
                        if (userId != null) {
                          await vm.fetchUserStudents(userId);
                        }

                        Navigator.pushReplacement(
                          // ignore: use_build_context_synchronously
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(application: student),
                          ),
                        );
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              vm.errorMessage ?? "Submission failed",
                            ),
                          ),
                        );
                      }
                    },

                    child: const Text(

                      'Submit Application',

                      style: TextStyle(

                        fontSize: 18,
                        color: Colors.white,
                      ),
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