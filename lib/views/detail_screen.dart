/*
*Student Numbers:224043099, 224014647, 224125791, 224081629, 224083089
*Student Names  : Masendeke Chiedza P, Mahlangu Phindile, Khunyeli Paballo, Ntlati Thembinkosi T, Tshabane Lonwabo
*Question : Detailacsreen 
*/
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

class _DetailScreenState extends State<DetailScreen> {
  late StudentApplication myApplication;

  @override
  void initState() {
    super.initState();
    myApplication = widget.application;
  }

  Future<void> _confirmDeletion() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Application?"),
        content: const Text("This action cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm != true) return;
    if (myApplication.id == null) return;

    // ignore: use_build_context_synchronously
    await context.read<StudentViewModel>().deleteStudent(myApplication.id!);

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),
        title: const Text("Application Details",
            style: TextStyle(color: Colors.white)),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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