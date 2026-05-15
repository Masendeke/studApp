// ignore_for_file: deprecated_member_use, use_build_context_synchronously

/*
*Student Numbers:224043099, 224014647, 224125791, 224081629, 224083089
*Student Names  : Masendeke Chiedza P, Mahlangu Phindile,
*Khunyeli Paballo, Ntlati Thembinkosi T, Tshabane Lonwabo
*Question : Homescreen
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/app_routes.dart';
import '../viewmodel/auth_viewmodel.dart';
import '../viewmodel/viewmodel.dart';
import '../model/model.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {

      if (mounted) {

        final authVM =
            context.read<AuthViewModel>();

        final userId =
            authVM.currentUserId;

        if (userId != null) {

          context
              .read<StudentViewModel>()
              .fetchUserStudents(userId);
        }
      }
    });
  }

  Color getStatusColor(String? status) {

    switch (status) {

      case 'Approved':
        return Colors.green;

      case 'Rejected':
        return Colors.red;

      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {

    final studentVM =
        context.watch<StudentViewModel>();

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [

              Color(0xFF0B1F8F),
              Color(0xFF1976D2),
              Colors.white
            ],
          ),
        ),

        child: Padding(

          padding:
              const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 40),

              _buildHeader(),

              const SizedBox(height: 30),

              _buildButtons(context),

              const SizedBox(height: 35),

              const Text(

                "My Applications",

                style: TextStyle(

                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              _buildApplicationsList(
                studentVM,
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // HEADER
  Widget _buildHeader() {

    return Row(

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
    );
  }

  // BUTTONS
  Widget _buildButtons(
      BuildContext context) {

    return Row(

      children: [

        ElevatedButton.icon(

          style:
              ElevatedButton.styleFrom(

            backgroundColor: Colors.white,

            foregroundColor:
                const Color(0xFF0B1F8F),

            padding:
                const EdgeInsets.symmetric(

              horizontal: 22,
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

          label: const Text("Apply"),
        ),

        const SizedBox(width: 15),

        ElevatedButton.icon(

          style:
              ElevatedButton.styleFrom(

            backgroundColor:
                const Color(0xFF0B1F8F),

            foregroundColor: Colors.white,

            padding:
                const EdgeInsets.symmetric(

              horizontal: 22,
              vertical: 15,
            ),
          ),

          onPressed: () {

            _showManageDialog(context);
          },

          icon: const Icon(Icons.edit),

          label: const Text("Manage"),
        ),
      ],
    );
  }

  // APPLICATION LIST
  Widget _buildApplicationsList(
    StudentViewModel vm,
    BuildContext context,
  ) {

    if (vm.isLoading) {

      return const Expanded(

        child: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (vm.allPersons.isEmpty) {

      return const Expanded(

        child: Center(

          child: Text(

            "No applications found",

            style: TextStyle(

              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Expanded(

      child: ListView.builder(

        itemCount: vm.allPersons.length,

        itemBuilder: (context, index) {

          final student =
              vm.allPersons[index];

          return Card(

            elevation: 4,

            margin:
                const EdgeInsets.only(
              bottom: 15,
            ),

            shape:
                RoundedRectangleBorder(

              borderRadius:
                  BorderRadius.circular(18),
            ),

            child: ListTile(

              contentPadding:
                  const EdgeInsets.all(15),

              leading: const CircleAvatar(

                backgroundColor:
                    Color(0xFFBBDEFB),

                child: Icon(

                  Icons.school,

                  color:
                      Color(0xFF0B1F8F),
                ),
              ),

              title: Text(student.course),

              subtitle: Text(
                "${student.name} ${student.surname}",
              ),

              trailing: Text(

                student.status,

                style: TextStyle(

                  color: getStatusColor(
                    student.status,
                  ),

                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              onTap: () {

                Navigator.pushNamed(

                  context,

                  AppRoutes.details,

                  arguments: student,
                );
              },

              onLongPress: () {

                _confirmDelete(
                  context,
                  student,
                );
              },
            ),
          );
        },
      ),
    );
  }

  // MANAGE DIALOG
  void _showManageDialog(
      BuildContext context) {

    final vm =
        context.read<StudentViewModel>();

    showModalBottomSheet(

      context: context,

      shape:
          const RoundedRectangleBorder(

        borderRadius:
            BorderRadius.vertical(

          top: Radius.circular(25),
        ),
      ),

      builder: (context) {

        return Padding(

          padding:
              const EdgeInsets.all(20),

          child: SingleChildScrollView(
            child: Column(
            
              mainAxisSize:
                  MainAxisSize.max,
            
              children: [
            
                const Text(
            
                  "Manage Applications",
            
                  style: TextStyle(
            
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
            
                const SizedBox(height: 20),
            
                // SORT A-Z
                ListTile(
            
                  leading:
                      const Icon(Icons.sort_by_alpha),
            
                  title:
                      const Text("Sort A - Z"),
            
                  onTap: () {
            
                    setState(() {
            
                      vm.allPersons.sort(
            
                        (a, b) => a.name
                            .toLowerCase()
                            .compareTo(
                              b.name
                                  .toLowerCase(),
                            ),
                      );
                    });
            
                    Navigator.pop(context);
                  },
                ),
            
                // SORT Z-A
                ListTile(
            
                  leading: const Icon(
            
                    Icons.sort_by_alpha,
            
                    color: Colors.red,
                  ),
            
                  title:
                      const Text("Sort Z - A"),
            
                  onTap: () {
            
                    setState(() {
            
                      vm.allPersons.sort(
            
                        (a, b) => b.name
                            .toLowerCase()
                            .compareTo(
                              a.name
                                  .toLowerCase(),
                            ),
                      );
                    });
            
                    Navigator.pop(context);
                  },
                ),
            
                // NEWEST
                ListTile(
            
                  leading:
                      const Icon(Icons.access_time),
            
                  title: const Text(
                    "Newest Applications",
                  ),
            
                  onTap: () {
            
                    setState(() {
            
                      vm.allPersons.sort(
            
                        (a, b) => (b.createdAt ??
                                DateTime.now())
                            .compareTo(
                          a.createdAt ??
                              DateTime.now(),
                        ),
                      );
                    });
            
                    Navigator.pop(context);
                  },
                ),
            
                // OLDEST
                ListTile(
            
                  leading:
                      const Icon(Icons.history),
            
                  title: const Text(
                    "Oldest Applications",
                  ),
            
                  onTap: () {
            
                    setState(() {
            
                      vm.allPersons.sort(
            
                        (a, b) => (a.createdAt ??
                                DateTime.now())
                            .compareTo(
                          b.createdAt ??
                              DateTime.now(),
                        ),
                      );
                    });
            
                    Navigator.pop(context);
                  },
                ),
            
                // SORT BY COURSE
                ListTile(
            
                  leading:
                      const Icon(Icons.school),
            
                  title:
                      const Text("Sort By Course"),
            
                  onTap: () {
            
                    setState(() {
            
                      vm.allPersons.sort(
            
                        (a, b) => a.course
                            .toLowerCase()
                            .compareTo(
                              b.course
                                  .toLowerCase(),
                            ),
                      );
                    });
            
                    Navigator.pop(context);
                  },
                ),
            
                const Divider(),
            
                // DELETE APPROVED
                ListTile(
            
                  leading: const Icon(
            
                    Icons.delete,
            
                    color: Colors.green,
                  ),
            
                  title: const Text(
                    "Delete Approved",
                  ),
            
                  onTap: () {
            
                    setState(() {
            
                      vm.allPersons.removeWhere(
            
                        (student) =>
                            student.status ==
                            "Approved",
                      );
                    });
            
                    Navigator.pop(context);
            
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
            
                      const SnackBar(
            
                        content: Text(
                          "Approved applications deleted",
                        ),
                      ),
                    );
                  },
                ),
            
                // DELETE REJECTED
                ListTile(
            
                  leading: const Icon(
            
                    Icons.delete,
            
                    color: Colors.red,
                  ),
            
                  title: const Text(
                    "Delete Rejected",
                  ),
            
                  onTap: () {
            
                    setState(() {
            
                      vm.allPersons.removeWhere(
            
                        (student) =>
                            student.status ==
                            "Rejected",
                      );
                    });
            
                    Navigator.pop(context);
            
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
            
                      const SnackBar(
            
                        content: Text(
                          "Rejected applications deleted",
                        ),
                      ),
                    );
                  },
                ),
            
                // DELETE ALL
                ListTile(
            
                  leading: const Icon(
            
                    Icons.delete_forever,
            
                    color: Colors.black,
                  ),
            
                  title: const Text(
                    "Delete All Applications",
                  ),
            
                  onTap: () {
            
                    setState(() {
            
                      vm.allPersons.clear();
                    });
            
                    Navigator.pop(context);
            
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
            
                      const SnackBar(
            
                        content: Text(
                          "All applications deleted",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // DELETE ONE APPLICATION
  void _confirmDelete(
    BuildContext context,
    StudentApplication student,
  ) {

    final scaffoldContext = context;

    showDialog(

      context: context,

      builder: (dialogContext) {

        return AlertDialog(

          title:
              const Text("Delete Application"),

          content: Text(

            "Delete ${student.name} ${student.surname}'s application?",
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                  dialogContext,
                );
              },

              child: const Text("Cancel"),
            ),

            TextButton(

              onPressed: () async {

                Navigator.pop(dialogContext);

                if (student.id != null) {

                  await scaffoldContext
                      .read<StudentViewModel>()
                      .deleteStudent(
                        student.id!,
                      );

                  if (mounted) {

                    ScaffoldMessenger.of(
                            scaffoldContext)
                        .showSnackBar(

                      const SnackBar(

                        content: Text(
                          "Application deleted",
                        ),
                      ),
                    );
                  }
                }
              },

              child: const Text(

                "Delete",

                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}