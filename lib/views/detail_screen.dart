//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';
import '../viewmodel/viewmodel.dart';
import 'edit_application_screen.dart';

class DetailScreen extends StatefulWidget {
  final StudentApplication application;

  const DetailScreen({
    super.key,
    required this.application,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

<<<<<<< HEAD
class _DetailScreenState extends State<DetailScreen> {
=======
class _DetailScreenState extends State<DetailScreen> {//this screen is used to show the details of the application and also to delete the application
// The myApplication variable is used to hold the current state of the application details, allowing us to update the UI after deletion without needing to refetch data from the database
>>>>>>> main
  late StudentApplication myApplication;

  @override
  void initState() {// Initialize the myApplication variable with the application passed from the previous screen when the DetailScreen is first created
    super.initState();
    myApplication = widget.application;
  }

<<<<<<< HEAD
  Future<void> _confirmDeletion() async {
    final confirm = await showDialog<bool>(
=======
  void _confirmDeletion() async {// Show a confirmation dialog before deleting the application to prevent accidental deletions
// If the user confirms the deletion, call the deleteStudent method from the StudentViewModel to delete the application from the database, and then navigate back to the HomeScreen
    final bool? confirm = await showDialog<bool>(
>>>>>>> main
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Application?"),
        content: const Text("This action cannot be undone."),
        actions: [
<<<<<<< HEAD
=======
// The Cancel button will simply close the dialog and return false, while the Delete button will return true to indicate that the user has confirmed the deletion
>>>>>>> main
          TextButton(
            onPressed: () => Navigator.pop(context, false),// Return false when the user cancels the deletion
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),// Return true when the user confirms the deletion
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {// If the user confirmed the deletion and the widget is still mounted, proceed to delete the application
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

<<<<<<< HEAD
    if (confirm != true) return;
    if (myApplication.id == null) return;

    // ignore: use_build_context_synchronously
    await context.read<StudentViewModel>().deleteStudent(myApplication.id!);
=======
    if (confirm == true && mounted) {
// If the user confirmed the deletion and the widget is still mounted, proceed to delete the application
      await context
          .read<StudentViewModel>()
          .deleteStudent(myApplication.id);
>>>>>>> main

    if (!mounted) return;
    Navigator.pop(context);
  }

  Widget buildRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            )),
        const SizedBox(height: 5),
        Text(value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 12),
        Container(height: 1, color: Colors.white24),
        const SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
// Build the UI for the DetailScreen, displaying the application details and providing a button to delete the application
>>>>>>> main
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),
        title: const Text("Application Details",
            style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
// The body of the screen is styled with a gradient background and displays the student's name, status, student number, email, and course details in a styled manner, and also provides a button to delete the application
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
<<<<<<< HEAD
=======
// Display the student's name, status, student number, email, and course details in a styled manner, and also provide a button to delete the application
>>>>>>> main
              Text(
                myApplication.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              buildRow("Status", myApplication.status),
              buildRow("Student Number", myApplication.stdNo),
              buildRow("Email", myApplication.email),
              buildRow("Phone", myApplication.phone),
              buildRow("Course", myApplication.course),
              buildRow("Year of Study", myApplication.yearOfStudy),
              buildRow("Module 1", myApplication.module1),
              buildRow("Module 2", myApplication.module2),

              const SizedBox(height: 20),

              // EDIT BUTTON
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
                  onPressed: () async {
                    final updatedApp =
                        await Navigator.push<StudentApplication>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditApplicationScreen(
                          app: myApplication,
                        ),
                      ),
                    );

                    if (updatedApp != null && mounted) {
                      setState(() {
                        myApplication = updatedApp;
                      });
                    }
                  },
                  child: const Text(
                    "Edit Application",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // DELETE BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
<<<<<<< HEAD
=======
// The Delete Application button will trigger the _confirmDeletion method when pressed, which will handle the deletion process with a confirmation dialog
>>>>>>> main
                  onPressed: _confirmDeletion,
                  child: const Text(
                    "Delete Application",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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