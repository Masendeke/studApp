//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:student_assistant_application/model/model.dart';

class EditApplicationScreen extends StatefulWidget {//this screen is used to edit the application details and also to update the application details in the database
  final StudentApplication app;// The app variable is used to hold the current state of the application details, allowing us to update the UI after editing without needing to refetch data from the database

  const EditApplicationScreen({//The constructor of the EditApplicationScreen takes a StudentApplication object as an argument, which is passed from the DetailScreen when the user clicks the edit button
    super.key,
    required this.app,
  });
// The EditApplicationScreen is a StatefulWidget because we need to manage the state of the text fields and update the UI after editing the application details
  @override
  State<EditApplicationScreen> createState() =>
      _EditApplicationScreenState();// The createState method creates the mutable state for this widget, which is managed by the _EditApplicationScreenState class
}

class _EditApplicationScreenState
    extends State<EditApplicationScreen> {
// The _EditApplicationScreenState class manages the state of the EditApplicationScreen, including the text controllers for the input fields and the logic for saving changes to the application details
  late TextEditingController _studNoController;
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _yearController;
  late TextEditingController _module1Controller;
  late TextEditingController _module2Controller;
  late TextEditingController _courseController;

  @override
  void initState() {// Initialize the text controllers with the current application details when the screen is first created, allowing the user to see the existing details and edit them as needed
    super.initState();

    _studNoController =
        TextEditingController(text: widget.app.stdNo);// The student number controller is initialized with the current student number from the application details, allowing the user to see and edit the existing student number

    _emailController =
        TextEditingController(text: widget.app.email);// The email controller is initialized with the current email from the application details, allowing the user to see and edit the existing email

    _nameController =
        TextEditingController(text: widget.app.name);// The name controller is initialized with the current name from the application details, allowing the user to see and edit the existing name

    _surnameController =
        TextEditingController(text: widget.app.surname);// The surname controller is initialized with the current surname from the application details, allowing the user to see and edit the existing surname

    _yearController =
        TextEditingController(text: widget.app.yearOfStudy);// The year of study controller is initialized with the current year of study from the application details, allowing the user to see and edit the existing year of study

    _module1Controller =
        TextEditingController(text: widget.app.module1);// The module 1 controller is initialized with the current module 1 from the application details, allowing the user to see and edit the existing module 1

    _module2Controller =
        TextEditingController(text: widget.app.module2);// The module 2 controller is initialized with the current module 2 from the application details, allowing the user to see and edit the existing module 2

    _courseController =
        TextEditingController(text: widget.app.course);// The course controller is initialized with the current course from the application details, allowing the user to see and edit the existing course
  }

  @override
  void dispose() {// Dispose of the text controllers when the screen is disposed to free up resources and prevent memory leaks, as the controllers are no longer needed once the user has finished editing the application details
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