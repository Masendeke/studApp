//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081442 Nlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../viewmodel/viewmodel.dart';
import '../views/detail_screen.dart';

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

  PlatformFile? selectedFile;

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
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFF0B1F8F),
          width: 2,
        ),
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
     initialValue: selectedYear,
      decoration: buildInputDecoration(label: label),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChanged,
      validator: (value) =>
          value == null ? '$label is required' : null,
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
                    icon: Icons.badge,
                  ),
                  validator: (v) =>
                      v!.isEmpty ? 'Required' : null,
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: viewModel.name,
                  decoration: buildInputDecoration(
                    label: 'First Name',
                    icon: Icons.person,
                  ),
                  validator: (v) =>
                      v!.length < 2 ? 'Invalid name' : null,
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: viewModel.surname,
                  decoration: buildInputDecoration(
                    label: 'Surname',
                    icon: Icons.person_outline,
                  ),
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: viewModel.email,
                  decoration: buildInputDecoration(
                    label: 'Email',
                    icon: Icons.email,
                  ),
                ),

                const SizedBox(height: 30),

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
                  label: 'Year of Study',
                  value: selectedYear,
                  items: years,
                  onChanged: (v) {
                    setState(() {
                      selectedYear = v;
                      viewModel.year.text = v ?? '';
                    });
                  },
                ),

                const SizedBox(height: 25),

                buildDropdownField(
                  label: 'Module Level',
                  value: module1Level,
                  items: academicLevels,
                  onChanged: (v) {
                    setState(() {
                      module1Level = v;
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
                        modulesByLevel[module1Level] ?? [],
                    onChanged: (v) {
                      setState(() {
                        module1Name = v;
                        viewModel.module.text = v ?? '';
                      });
                    },
                  ),

                const SizedBox(height: 25),

                CheckboxListTile(
                  value: secondModuleEnabled,
                  title: const Text(
                    'Apply for second module',
                    style: TextStyle(color: Colors.white),
                  ),
                  onChanged: (v) {
                    setState(() {
                      secondModuleEnabled = v!;
                      module2Level = null;
                      module2Name = null;
                    });
                  },
                ),

                if (secondModuleEnabled) ...[
                  buildDropdownField(
                    label: 'Second Module Level',
                    value: module2Level,
                    items: academicLevels,
                    onChanged: (v) {
                      setState(() {
                        module2Level = v;
                      });
                    },
                  ),
                ],

                const SizedBox(height: 25),

                // FILE UPLOAD
                const Text(
                  'Supporting Document',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ElevatedButton.icon(
                  icon: const Icon(Icons.upload_file),
                  label: const Text("Upload Document"),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: [
                        'pdf',
                        'doc',
                        'docx'
                      ],
                    );

                    if (result != null) {
                      setState(() {
                        selectedFile =
                            result.files.first;
                      });
                    }
                  },
                ),

                Text(
                  selectedFile != null
                      ? selectedFile!.name
                      : "No file selected",
                  style:
                      const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 20),

                CheckboxListTile(
                  value: eligibilityConfirmed,
                  title: const Text(
                    'I confirm eligibility',
                    style: TextStyle(color: Colors.white),
                  ),
                  onChanged: (v) {
                    setState(() {
                      eligibilityConfirmed = v!;
                    });
                  },
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF0B1F8F),
                    ),
                    onPressed: () {
                      if (selectedFile == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Upload supporting document'),
                          ),
                        );
                        return;
                      }

                      if (!eligibilityConfirmed) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Confirm eligibility'),
                          ),
                        );
                        return;
                      }

                      viewModel.submitApplication();

                      if (viewModel.status ==
                          'Submitted') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const Detailscreen(),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Submit Application',
                      style:
                          TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Status: ${viewModel.status}',
                  style: TextStyle(
                    color:
                        viewModel.status == 'Submitted'
                            ? Colors.green
                            : Colors.orange,
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