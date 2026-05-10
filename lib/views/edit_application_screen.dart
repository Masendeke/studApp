//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081442 Nlati TT
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
  late TextEditingController _yearofstudController;
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

    _yearofstudController =
        TextEditingController(
      text: widget.app.yearOfStudy,
    );

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
    _yearofstudController.dispose();
    _module1Controller.dispose();
    _module2Controller.dispose();
    _courseController.dispose();

    super.dispose();
  }

  // INPUT DESIGN
  InputDecoration buildInputDecoration({
    required String label,
    IconData? icon,
  }) {

    return InputDecoration(

      labelText: label,

      labelStyle: const TextStyle(
        color: Colors.black87,
      ),

      prefixIcon:
          icon != null
              ? Icon(
                  icon,
                  color: const Color(0xFF0B1F8F),
                )
              : null,

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        backgroundColor:
            const Color(0xFF0B1F8F),

        title: const Text(
          "Edit Information",

          style: TextStyle(
            color: Colors.white,
          ),
        ),

        iconTheme: const IconThemeData(
          color: Colors.white,
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

          child: Column(

            children: [

              TextField(
                controller: _studNoController,

                decoration:
                    buildInputDecoration(
                  label: "Student Number",
                  icon: Icons.badge,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: _emailController,

                decoration:
                    buildInputDecoration(
                  label: "Email",
                  icon: Icons.email,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: _nameController,

                decoration:
                    buildInputDecoration(
                  label: "Name",
                  icon: Icons.person,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller: _surnameController,

                decoration:
                    buildInputDecoration(
                  label: "Surname",
                  icon: Icons.person_outline,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller:
                    _yearofstudController,

                decoration:
                    buildInputDecoration(
                  label: "Year of Study",
                  icon: Icons.school,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller:
                    _module1Controller,

                decoration:
                    buildInputDecoration(
                  label: "Module 1",
                  icon: Icons.book,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller:
                    _module2Controller,

                decoration:
                    buildInputDecoration(
                  label: "Module 2",
                  icon: Icons.menu_book,
                ),
              ),

              const SizedBox(height: 18),

              TextField(
                controller:
                    _courseController,

                decoration:
                    buildInputDecoration(
                  label: "Course",
                  icon: Icons.cast_for_education,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(

                width: double.infinity,
                height: 55,

                child: ElevatedButton(

                  style:
                      ElevatedButton.styleFrom(

                    backgroundColor:
                        const Color(
                      0xFF0B1F8F,
                    ),

                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                        15,
                      ),
                    ),
                  ),

                  onPressed: () {

                    // UPDATE DATA
                    widget.app.stdNo =
                        _studNoController.text;

                    widget.app.email =
                        _emailController.text;

                    widget.app.name =
                        _nameController.text;

                    widget.app.surname =
                        _surnameController.text;

                    widget.app.yearOfStudy =
                        _yearofstudController.text;

                    widget.app.module1 =
                        _module1Controller.text;

                    widget.app.module2 =
                        _module2Controller.text;

                    widget.app.course =
                        _courseController.text;

                    Navigator.pop(
                      context,
                      widget.app,
                    );
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