//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/viewmodel.dart';
import '../views/person_details_screen.dart';

class Admindashboardscreen extends StatefulWidget {
  const Admindashboardscreen({super.key});

  @override
  State<Admindashboardscreen> createState() =>
      _AdmindashboardscreenState();
}// The Admindashboardscreen is a StatefulWidget that displays a list of student applications for the admin to review, and allows navigation to the PersonDetailsScreen when an application is tapped, passing the selected student's details as arguments for further review and management of the application status.

class _AdmindashboardscreenState
    extends State<Admindashboardscreen> {
// The _AdmindashboardscreenState class manages the state of the Admindashboardscreen, including fetching the student applications and displaying them in a list, as well as handling navigation to the PersonDetailsScreen when an application is tapped, passing the selected student's details as arguments for further review and management of the application status.
  @override
  void initState() {
    super.initState();

    Future.microtask(() {// The Future.microtask is used to ensure that the fetchStudents method is called after the widget has been fully initialized, allowing us to fetch the student applications from the database and update the UI accordingly when the admin dashboard screen is first displayed
      Provider.of<StudentViewModel>(
        // ignore: use_build_context_synchronously
        context,
        listen: false,
      ).fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {// The build method builds the UI for the admin dashboard screen, displaying a list of student applications with their names, student numbers, and application statuses. When an application is tapped, it navigates to the PersonDetailsScreen, passing the selected student's details as arguments for further review and management of the application status.
    return Consumer<StudentViewModel>(// The Consumer widget listens to changes in the StudentViewModel and rebuilds the UI accordingly when the list of student applications is updated, ensuring that the admin dashboard always displays the most current data from the database.
      builder: (context, vm, _) {
        final students = vm.students;

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

            child: Scaffold(
              backgroundColor: Colors.transparent,

              appBar: AppBar(
                title: const Text(
                  'Admin Dashboard',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),

              body: students.isEmpty
                  ? const Center(
                      child: Text(
                        "No applications yet",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];

                        return Card(
                          child: ListTile(
                            title: Text(
                              '${student.name} ${student.surname}',
                            ),
                            subtitle: Text(student.stdNo),
                            trailing: Text(student.status),

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      PersonDetailsScreen(
                                    person: student,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ),
        );
      },
    );
  }
}