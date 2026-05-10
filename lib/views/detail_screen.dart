//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081442 Nlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:student_assistant_application/model/model.dart';
import 'edit_application_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  StudentApplication myApplication = StudentApplication(
    status: 'pending',
    stdNo: '224043099',
    email: 'student@gmail.com',
    name: 'Trish',
    surname: 'Masendeke',
    yearOfStudy: 'Second Year',
    module1: 'TPG211',
    module2: 'DBS210',
    course: 'Information Technology',
  );

  void _confirmDeletion() async {

    final bool? confirm = await showDialog<bool>(

      context: context,

      builder: (context) => AlertDialog(

        title: const Text(
          "Do you want to delete your application?",
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },

            child: const Text(
              "Delete",

              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),

          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },

            child: const Text("Cancel"),
          ),
        ],
      ),
    );

    if (confirm == true && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1F8F),

        title: const Text(
          "Application Details",

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

        child: Padding(
          padding: const EdgeInsets.all(15),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                myApplication.name,

                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "Status: ${myApplication.status.toUpperCase()}",

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const Divider(color: Colors.white),

              Text(
                "Student No: ${myApplication.stdNo}",

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const Divider(color: Colors.white),

              Text(
                "Email: ${myApplication.email}",

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const Divider(color: Colors.white),

              Text(
                "Name: ${myApplication.name}",

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const Divider(color: Colors.white),

              Text(
                "Surname: ${myApplication.surname}",

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const Divider(color: Colors.white),

              Text(
                "Year Of Study: ${myApplication.yearOfStudy}",

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const Divider(color: Colors.white),

              Text(
                "First Module: ${myApplication.module1}",

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const Divider(color: Colors.white),

              Text(
                "Second Module: ${myApplication.module2}",

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const Divider(color: Colors.white),

              Text(
                "Course: ${myApplication.course}",

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),

              const Spacer(),

              if (myApplication.status == "pending") ...[

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(

                      backgroundColor:
                          const Color(0xFF0B1F8F),

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),

                    onPressed: () async {

                      final updatedApplication =
                          await Navigator.push<StudentApplication>(

                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                              EditApplicationScreen(
                            app: myApplication,
                          ),
                        ),
                      );

                      if (updatedApplication != null) {

                        setState(() {
                          myApplication =
                              updatedApplication;
                        });
                      }
                    },

                    child: const Text(
                      "Edit Information",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(

                      backgroundColor: Colors.red,

                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),
                    ),

                    onPressed: _confirmDeletion,

                    child: const Text(
                      "Delete Application",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}