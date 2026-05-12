import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';
import '../viewmodel/viewmodel.dart';


class DetailScreen extends StatefulWidget {
  final StudentApplication application;

  const DetailScreen({
    super.key,
    required this.application,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {//this screen is used to show the details of the application and also to delete the application
// The myApplication variable is used to hold the current state of the application details, allowing us to update the UI after deletion without needing to refetch data from the database
  late StudentApplication myApplication;

  @override
  void initState() {// Initialize the myApplication variable with the application passed from the previous screen when the DetailScreen is first created
    super.initState();
    myApplication = widget.application;
  }

  void _confirmDeletion() async {// Show a confirmation dialog before deleting the application to prevent accidental deletions
// If the user confirms the deletion, call the deleteStudent method from the StudentViewModel to delete the application from the database, and then navigate back to the HomeScreen
    final bool? confirm = await showDialog<bool>(
      context: context,

      builder: (context) => AlertDialog(
        title: const Text("Delete Application?"),

        content: const Text(
          "This action cannot be undone.",
        ),

        actions: [
// The Cancel button will simply close the dialog and return false, while the Delete button will return true to indicate that the user has confirmed the deletion
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

    if (confirm == true && mounted) {
// If the user confirmed the deletion and the widget is still mounted, proceed to delete the application
      await context
          .read<StudentViewModel>()
          .deleteStudent(myApplication.id);

      if (!mounted) return;

      Navigator.pop(context); // go back to HomeScreen
    }
  }

  @override
  Widget build(BuildContext context) {
// Build the UI for the DetailScreen, displaying the application details and providing a button to delete the application
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),

        title: const Text(
          "Application Details",
          style: TextStyle(color: Colors.white),
        ),

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

        child: Padding(
          padding: const EdgeInsets.all(15),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
// Display the student's name, status, student number, email, and course details in a styled manner, and also provide a button to delete the application
              Text(
                myApplication.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Status: ${myApplication.status}",
                style: const TextStyle(color: Colors.white),
              ),

              const SizedBox(height: 20),

              Text(
                "Student No: ${myApplication.stdNo}",
                style: const TextStyle(color: Colors.white),
              ),

              Text(
                "Email: ${myApplication.email}",
                style: const TextStyle(color: Colors.white),
              ),

              Text(
                "Course: ${myApplication.course}",
                style: const TextStyle(color: Colors.white),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
// The Delete Application button will trigger the _confirmDeletion method when pressed, which will handle the deletion process with a confirmation dialog
                  onPressed: _confirmDeletion,

                  child: const Text(
                    "Delete Application",
                    style: TextStyle(color: Colors.white),
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