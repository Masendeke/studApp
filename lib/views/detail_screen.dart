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

class _DetailScreenState extends State<DetailScreen> {

  late StudentApplication myApplication;

  @override
  void initState() {
    super.initState();
    myApplication = widget.application;
  }

  void _confirmDeletion() async {

    final bool? confirm = await showDialog<bool>(
      context: context,

      builder: (context) => AlertDialog(
        title: const Text("Delete Application?"),

        content: const Text(
          "This action cannot be undone.",
        ),

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

    if (confirm == true && mounted) {

      await context
          .read<StudentViewModel>()
          .deleteStudent(myApplication.id);

      if (!mounted) return;

      Navigator.pop(context); // go back to HomeScreen
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),

        title: const Text(
          "Application Details",
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

        child: Padding(
          padding: const EdgeInsets.all(15),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

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