//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:student_assistant_application/model/model.dart';

class EditApplicationScreen extends StatefulWidget {
  final StudentApplication app;

  const EditApplicationScreen({
    super.key,
    required this.app,
  });

  @override
  State<EditApplicationScreen> createState() =>
      _EditApplicationScreenState();
}

class _EditApplicationScreenState
    extends State<EditApplicationScreen> {

  late TextEditingController _studNoController;
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _yearController;
  late TextEditingController _module1Controller;
  late TextEditingController _module2Controller;
  late TextEditingController _courseController;

  @override
  void initState() {
    super.initState();

    _studNoController =
        TextEditingController(text: widget.app.stdNo);

    _emailController =
        TextEditingController(text: widget.app.email);

    _nameController =
        TextEditingController(text: widget.app.name);

    _surnameController =
        TextEditingController(text: widget.app.surname);

    _yearController =
        TextEditingController(text: widget.app.yearOfStudy);

    _module1Controller =
        TextEditingController(text: widget.app.module1);

    _module2Controller =
        TextEditingController(text: widget.app.module2);

    _courseController =
        TextEditingController(text: widget.app.course);
  }

  @override
  void dispose() {
    _studNoController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _yearController.dispose();
    _module1Controller.dispose();
    _module2Controller.dispose();
    _courseController.dispose();
    super.dispose();
  }

  InputDecoration buildInput(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: const Color(0xFF0B1F8F)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),
        title: const Text(
          "Edit Application",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
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

          child: Column(
            children: [

              TextField(
                controller: _studNoController,
                decoration: buildInput("Student Number", Icons.badge),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: _emailController,
                decoration: buildInput("Email", Icons.email),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: _nameController,
                decoration: buildInput("Name", Icons.person),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: _surnameController,
                decoration: buildInput("Surname", Icons.person_outline),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: _yearController,
                decoration: buildInput("Year of Study", Icons.school),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: _module1Controller,
                decoration: buildInput("Module 1", Icons.book),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: _module2Controller,
                decoration: buildInput("Module 2", Icons.menu_book),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: _courseController,
                decoration: buildInput("Course", Icons.cast_for_education),
              ),

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

                  onPressed: () {
                    final updated = StudentApplication(
                      id: widget.app.id,
                      stdNo: _studNoController.text,
                      email: _emailController.text,
                      name: _nameController.text,
                      surname: _surnameController.text,
                      yearOfStudy: _yearController.text,
                      module1: _module1Controller.text,
                      module2: _module2Controller.text,
                      course: _courseController.text,
                      phone: widget.app.phone,
                      status: widget.app.status,
                      createdAt: widget.app.createdAt,
                      updatedAt: DateTime.now(),
                    );

                    Navigator.pop(context, updated);
                  },

                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
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