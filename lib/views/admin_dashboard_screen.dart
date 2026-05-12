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
}

class _AdmindashboardscreenState
    extends State<Admindashboardscreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<StudentViewModel>(
        // ignore: use_build_context_synchronously
        context,
        listen: false,
      ).fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentViewModel>(
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