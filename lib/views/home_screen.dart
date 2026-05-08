import 'package:flutter/material.dart';
import 'package:student_assistant_application/routes/app_routes.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  // Dummy application data
  final List<Map<String, String>> applications = [
    {
      'position': 'Library Assistant',
      'status': 'Pending',
      'date': '03 May 2026',
    },
    {
      'position': 'Tutor Assistant',
      'status': 'Approved',
      'date': '28 April 2026',
    },
    {
      'position': 'Lab Assistant',
      'status': 'Rejected',
      'date': '20 April 2026',
    },
  ];

  Color getStatusColor(String status) {
    if (status == 'Approved') {
      return Colors.green;
    } else if (status == 'Rejected') {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text(
          "Student Dashboard",
        ),

        backgroundColor: Colors.blue,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Icon(
                    Icons.school,
                    color: Colors.white,
                    size: 40,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Manage and track your student assistant applications.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Buttons Row
            Row(
              children: [

                // Apply Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),

                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.apply,
                    );
                  },

                  icon: const Icon(Icons.add),

                  label: const Text(
                    "Apply",
                  ),
                ),

                const SizedBox(width: 15),

                // Manage Button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),

                  onPressed: () {},

                  icon: const Icon(Icons.edit),

                  label: const Text(
                    "Manage",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "My Applications",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Application Cards
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,

                  child: Icon(
                    Icons.work,
                    color: Colors.white,
                  ),
                ),

                title: Text(
                  applications[0]['position']!,
                ),

                subtitle: Text(
                  "Submitted: ${applications[0]['date']}",
                ),

                trailing: Text(
                  applications[0]['status']!,

                  style: TextStyle(
                    color: getStatusColor(
                      applications[0]['status']!,
                    ),

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,

                  child: Icon(
                    Icons.menu_book,
                    color: Colors.white,
                  ),
                ),

                title: Text(
                  applications[1]['position']!,
                ),

                subtitle: Text(
                  "Submitted: ${applications[1]['date']}",
                ),

                trailing: Text(
                  applications[1]['status']!,

                  style: TextStyle(
                    color: getStatusColor(
                      applications[1]['status']!,
                    ),

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.red,

                  child: Icon(
                    Icons.computer,
                    color: Colors.white,
                  ),
                ),

                title: Text(
                  applications[2]['position']!,
                ),

                subtitle: Text(
                  "Submitted: ${applications[2]['date']}",
                ),

                trailing: Text(
                  applications[2]['status']!,

                  style: TextStyle(
                    color: getStatusColor(
                      applications[2]['status']!,
                    ),

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}