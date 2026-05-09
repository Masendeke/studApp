//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081442 Nlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/viewmodel.dart';

class Applicationformscreen extends StatefulWidget {
  const Applicationformscreen({super.key});

  @override
  State<Applicationformscreen> createState() =>
      _ApplicationformscreenState();
}

class _ApplicationformscreenState
    extends State<Applicationformscreen> {
  String? selectedYear;

  String? module1Level;
  String? module1Name;

  String? module2Level;
  String? module2Name;

  bool secondModuleEnabled = false;
  bool eligibilityConfirmed = false;

  final TextEditingController supportingDocumentController =
      TextEditingController();

  final List<String> years = [
    'First Year',
    'Second Year',
    'Third Year'
  ];

  final List<String> academicLevels = [
    'First Year',
    'Second Year',
    'Third Year'
  ];

  final Map<String, List<String>> modulesByLevel = {
    'First Year': ['ICT101', 'TPG111', 'MAT101'],
    'Second Year': ['TPG211', 'DBS210', 'WPR221'],
    'Third Year': ['TPG316C', 'PRJ300', 'SEC310'],
  };

  @override
  void dispose() {
    supportingDocumentController.dispose();
    super.dispose();
  }

  // MODERN INPUT STYLE
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

      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 15,
      ),

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
      initialValue: value,

      decoration: buildInputDecoration(
        label: label,
      ),

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
    final viewModel = Provider.of<StudentViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),
        title: const Text(
          'Student Assistant Application Form',
          style: TextStyle(color: Colors.white),
        ),
         leading:IconButton( icon: const Icon(Icons.arrow_back,color: Colors.white,),
      onPressed: (){
        Navigator.pop(context);
      },)
      ),

      body: Container(
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

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Form(
            key: viewModel.formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                // PERSONAL INFO
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
                  controller: viewModel.stdNo,

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
                  controller: viewModel.name,

                  decoration: buildInputDecoration(
                    label: 'First Name',
                    hint: 'Enter first name',
                    icon: Icons.person,
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First name is required';
                    }

                    if (value.length < 2) {
                      return 'Name must be at least 2 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: viewModel.surname,

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
                  controller: viewModel.email,
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
                      return 'Enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: viewModel.course,

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

                // ACADEMIC INFO
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
                      viewModel.year.text = value ?? '';
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
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

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
                        viewModel.module.text = value ?? '';
                      });
                    },
                  ),

                const SizedBox(height: 25),

                CheckboxListTile(
                  activeColor: const Color(0xFF0B1F8F),

                  title: const Text(
                    'Apply for a second module',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  value: secondModuleEnabled,

                  onChanged: (value) {
                    setState(() {
                      secondModuleEnabled = value ?? false;

                      if (!secondModuleEnabled) {
                        module2Level = null;
                        module2Name = null;
                      }
                    });
                  },
                ),

                // MODULE 2
                if (secondModuleEnabled) ...[
                  const SizedBox(height: 10),

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
                      items:
                          modulesByLevel[module2Level] ?? [],

                      onChanged: (value) {
                        setState(() {
                          module2Name = value;
                        });
                      },
                    ),
                ],

                const SizedBox(height: 25),

                // SUPPORTING DOCUMENT
                TextFormField(
                  controller: supportingDocumentController,

                  decoration: buildInputDecoration(
                    label: 'Supporting Document',
                    hint: 'Enter transcript file name',
                    icon: Icons.upload_file,
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Supporting document is required';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 18),

                CheckboxListTile(
                  activeColor: const Color(0xFF0B1F8F),

                  title: const Text(
                    'I confirm that I meet the eligibility requirements',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  value: eligibilityConfirmed,

                  onChanged: (value) {
                    setState(() {
                      eligibilityConfirmed = value ?? false;
                    });
                  },
                ),

                const SizedBox(height: 30),

                // SUBMIT BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF0B1F8F),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),

                    onPressed: () {

                      if (!eligibilityConfirmed) {

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please confirm eligibility requirements.',
                            ),
                          ),
                        );

                        return;
                      }

                      viewModel.submitApplication();

                      if (viewModel.status == 'Submitted') {

                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Application submitted successfully!',
                            ),
                          ),
                        );

                        Navigator.pop(context);
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

                const SizedBox(height: 20),

                Center(
                  child: Text(
                    'Application Status: ${viewModel.status}',

                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                      color:
                          viewModel.status == 'Submitted'
                              ? Colors.green
                              : Colors.orange,
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