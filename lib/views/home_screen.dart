import 'package:flutter/material.dart';
import 'package:student_assistant_application/routes/app_routes.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B1F8F), Color(0xFF1976D2), Colors.white],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                // TOP SECTION
                Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,

                      decoration: BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.cover,
                         ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        
                      ),

                      

                       
                      
                    ),

                    const SizedBox(width: 15),

                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "Student Dashboard",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // BUTTONS
                Row(
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF0B1F8F),

                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 15,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.apply);
                      },

                      icon: const Icon(Icons.add),

                      label: const Text("Apply"),
                    ),

                    const SizedBox(width: 15),

                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B1F8F),

                        foregroundColor: Colors.white,

                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 15,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      onPressed: () {},

                      icon: const Icon(Icons.edit),

                      label: const Text("Manage"),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                const Text(
                  "My Applications",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                // CARD 1
                Card(
                  elevation: 4,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),

                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE3F2FD),

                      child: Icon(Icons.menu_book, color: Color(0xFF0B1F8F)),
                    ),

                    title: Text(applications[0]['position']!),

                    subtitle: Text("Submitted: ${applications[0]['date']}"),

                    trailing: Text(
                      applications[0]['status']!,

                      style: TextStyle(
                        color: getStatusColor(applications[0]['status']!),

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // CARD 2
                Card(
                  elevation: 4,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),

                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFE8F5E9),

                      child: Icon(Icons.school, color: Colors.green),
                    ),

                    title: Text(applications[1]['position']!),

                    subtitle: Text("Submitted: ${applications[1]['date']}"),

                    trailing: Text(
                      applications[1]['status']!,

                      style: TextStyle(
                        color: getStatusColor(applications[1]['status']!),

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // CARD 3
                Card(
                  elevation: 4,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),

                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFFEBEE),

                      child: Icon(Icons.computer, color: Colors.red),
                    ),

                    title: Text(applications[2]['position']!),

                    subtitle: Text("Submitted: ${applications[2]['date']}"),

                    trailing: Text(
                      applications[2]['status']!,

                      style: TextStyle(
                        color: getStatusColor(applications[2]['status']!),

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
