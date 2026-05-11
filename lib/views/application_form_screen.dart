//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081442 Nlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/viewmodel.dart';
import '../model/model.dart';
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
  String? module1Name;
  String? module2Name;

  bool eligibilityConfirmed = false;

  final List<String> years = [
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

  @override
  Widget build(BuildContext context) {

    final vm = context.read<StudentViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Application Form"),
        backgroundColor: const Color(0xFF0B1F8F),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              TextFormField(
                controller: stdNo,
                decoration: const InputDecoration(labelText: "Student No"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: "Name"),
              ),

              TextFormField(
                controller: surname,
                decoration: const InputDecoration(labelText: "Surname"),
              ),

              TextFormField(
                controller: email,
                decoration: const InputDecoration(labelText: "Email"),
              ),

              TextFormField(
                controller: phone,
                decoration: const InputDecoration(labelText: "Phone"),
              ),

              TextFormField(
                controller: course,
                decoration: const InputDecoration(labelText: "Course"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: vm.isLoading
                    ? null
                    : () async {

                        if (!_formKey.currentState!.validate()) return;

                        if (!eligibilityConfirmed) return;

                        final student = StudentApplication(
                          id: '',
                          stdNo: stdNo.text,
                          name: name.text,
                          surname: surname.text,
                          email: email.text,
                          phone: phone.text,
                          course: course.text,
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
                              builder: (_) => DetailScreen(
                                application: student,
                              ),
                            ),
                          );
                        }
                      },

                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}