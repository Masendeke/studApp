//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081442 Nlati TT
//224083089 Tshabane L
import 'package:flutter/material.dart';
import 'package:student_assistant_application/routes/app_routes.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  List<Map<String, String>> applications = [

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

  // DELETE METHOD
  void deleteApplication(int index) {

    setState(() {

      applications.removeAt(index);
    });
  }

  // STATUS COLORS
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

            colors: [

              Color(0xFF0B1F8F),
              Color(0xFF1976D2),
              Colors.white,
            ],
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

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(40),

                        image: const DecorationImage(

                          image: AssetImage(
                            "assets/logo.png",
                          ),

                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    const Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

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

                          style: TextStyle(

                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                // BUTTONS
                Row(

                  children: [

                    // APPLY BUTTON
                    ElevatedButton.icon(

                      style: ElevatedButton.styleFrom(

                        backgroundColor: Colors.white,

                        foregroundColor:
                            const Color(0xFF0B1F8F),

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal: 22,
                          vertical: 15,
                        ),

                        shape: RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),

                      onPressed: () {

                        Navigator.pushNamed(
                          context,
                          AppRoutes.apply,
                        );
                      },

                      icon: const Icon(Icons.add),

                      label: const Text("Apply"),
                    ),

                    const SizedBox(width: 15),

                    // MANAGE BUTTON
                    ElevatedButton.icon(

                      style: ElevatedButton.styleFrom(

                        backgroundColor:
                            const Color(0xFF0B1F8F),

                        foregroundColor: Colors.white,

                        padding:
                            const EdgeInsets.symmetric(

                          horizontal: 22,
                          vertical: 15,
                        ),

                        shape: RoundedRectangleBorder(

                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),

                      onPressed: () {

                        showDialog(

                          context: context,

                          builder: (context) {

                            return AlertDialog(

                              title: const Text(
                                "Manage Applications",
                              ),

                              content: const Text(
                                "Tap any application card to delete it.",
                              ),

                              actions: [

                                TextButton(

                                  onPressed: () {

                                    Navigator.pop(context);
                                  },

                                  child: const Text(
                                    "Close",
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },

                      icon: const Icon(Icons.edit),

                      label: const Text("Manage"),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                const Text(

                  "My Applications",

                  style: TextStyle(

                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                // APPLICATION LIST
                Expanded(

                  child: ListView.builder(

                    itemCount: applications.length,

                    itemBuilder: (context, index) {

                      return Padding(

                        padding: const EdgeInsets.only(
                          bottom: 15,
                        ),

                        child: Card(

                          elevation: 4,

                          shape: RoundedRectangleBorder(

                            borderRadius:
                                BorderRadius.circular(18),
                          ),

                          child: ListTile(

                            contentPadding:
                                const EdgeInsets.all(15),

                            leading: CircleAvatar(

                              backgroundColor:
                                  Colors.blue.shade100,

                              child: const Icon(

                                Icons.school,

                                color: Color(0xFF0B1F8F),
                              ),
                            ),

                            title: Text(
                              applications[index]['position']!,
                            ),

                            subtitle: Text(

                              "Submitted: ${applications[index]['date']}",
                            ),

                            trailing: Text(

                              applications[index]['status']!,

                              style: TextStyle(

                                color: getStatusColor(

                                  applications[index]['status']!,
                                ),

                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // DELETE ON TAP
                            onTap: () {

                              showDialog(

                                context: context,

                                builder: (context) {

                                  return AlertDialog(

                                    title: const Text(
                                      "Delete Application",
                                    ),

                                    content: const Text(
                                      "Are you sure you want to delete this application?",
                                    ),

                                    actions: [

                                      TextButton(

                                        onPressed: () {

                                          Navigator.pop(context);
                                        },

                                        child: const Text(
                                          "Cancel",
                                        ),
                                      ),

                                      TextButton(

                                        onPressed: () {

                                          deleteApplication(index);

                                          Navigator.pop(context);
                                        },

                                        child: const Text(
                                          "Delete",
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
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