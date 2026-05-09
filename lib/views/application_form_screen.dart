/*
 *  Student Numbers:
 *  Student Names:
 * Question: Application form Page
 */
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

  Widget buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
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
        title: const Text('Student Assistant Application Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: viewModel.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: viewModel.stdNo,
                decoration: const InputDecoration(
                  labelText: 'Student Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Student number is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: viewModel.name,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
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
              const SizedBox(height: 16),

              TextFormField(
                controller: viewModel.surname,
                decoration: const InputDecoration(
                  labelText: 'Surname',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Surname is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: viewModel.email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
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
              const SizedBox(height: 16),

              TextFormField(
                controller: viewModel.course,
                decoration: const InputDecoration(
                  labelText: 'Course / Qualification',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Course is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),
              const Text(
                'Academic Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

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

              const SizedBox(height: 24),
              const Text(
                'Module Application 1',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

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

              const SizedBox(height: 16),

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

              const SizedBox(height: 24),
              CheckboxListTile(
                title: const Text('Apply for a second module'),
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

              if (secondModuleEnabled) ...[
                const Text(
                  'Module Application 2',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

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

                const SizedBox(height: 16),

                if (module2Level != null)
                  DropdownButtonFormField<String>(
                    initialValue: module2Name,
                    decoration: const InputDecoration(
                      labelText: 'Module',
                      border: OutlineInputBorder(),
                    ),
                    items: (modulesByLevel[module2Level] ?? [])
                        .map((module) {
                      return DropdownMenuItem(
                        value: module,
                        child: Text(module),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        module2Name = value;
                      });
                    },
                    validator: (value) {
                      if (secondModuleEnabled) {
                        if (value == null || value.isEmpty) {
                          return 'Second module is required';
                        }
                        if (value == module1Name) {
                          return 'Duplicate module selection is not allowed';
                        }
                      }
                      return null;
                    },
                  ),
              ],

              const SizedBox(height: 24),
              TextFormField(
                controller: supportingDocumentController,
                decoration: const InputDecoration(
                  labelText: 'Supporting Document',
                  hintText: 'Enter transcript or document file name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Supporting document is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text(
                  'I confirm that I meet the eligibility requirements',
                ),
                value: eligibilityConfirmed,
                onChanged: (value) {
                  setState(() {
                    eligibilityConfirmed = value ?? false;
                  });
                },
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!eligibilityConfirmed) {
                      ScaffoldMessenger.of(context).showSnackBar(
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Application submitted successfully!',
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Submit Application'),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Application Status: ${viewModel.status}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: viewModel.status == 'Submitted'
                        ? Colors.green
                        : Colors.orange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
