/*
*Student Numbers:224043099, 224014647, 224125791, 224081629, 224083089
*Student Names  : Masendeke Chiedza P, Mahlangu Phindile, Khunyeli Paballo, Ntlati Thembinkosi T, Tshabane Lonwabo
*Question : Homescreen 
*/
// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routes/app_routes.dart';
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
        context.read<StudentViewModel>().fetchAllStudents();
      }
    });
  }

  Color getStatusColor(String? status) {
    switch (status) {
      case 'Approved': return Colors.green;
      case 'Rejected': return Colors.red;
      default: return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentVM = context.watch<StudentViewModel>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B1F8F), Color(0xFF1976D2), Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              _buildHeader(),
              const SizedBox(height: 30),
              _buildButtons(context),
              const SizedBox(height: 35),
              const Text("My Applications", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 20),
              _buildApplicationsList(studentVM, context),
            ],
          ),
        ),
      ),
    );
  }
//Instead of writing everything inside build(), you split it into smaller pieces.
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            image: const DecorationImage(image: AssetImage("assets/logo.png"), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 15),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
            Text("Student Dashboard", style: TextStyle(color: Colors.white70, fontSize: 16)),
          ],
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF0B1F8F),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          ),
          onPressed: () => Navigator.pushNamed(context, AppRoutes.apply),
          icon: const Icon(Icons.add),
          label: const Text("Apply"),
        ),
        const SizedBox(width: 15),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0B1F8F),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          ),
          onPressed: () => _showManageDialog(context),
          icon: const Icon(Icons.edit),
          label: const Text("Manage"),
        ),
      ],
    );
  }

  Widget _buildApplicationsList(StudentViewModel vm, BuildContext context) {
    if (vm.isLoading) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }
    
    if (vm.allPersons.isEmpty) {
      return const Expanded(
        child: Center(child: Text("No applications found", style: TextStyle(fontSize: 18, color: Colors.white))),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: vm.allPersons.length,
        itemBuilder: (context, index) {
          final student = vm.allPersons[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(15),
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFBBDEFB),
                child: Icon(Icons.school, color: Color(0xFF0B1F8F)),
              ),
              title: Text(student.course),
              subtitle: Text("${student.name} ${student.surname}"),
              trailing: Text(
                student.status,
                style: TextStyle(color: getStatusColor(student.status), fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.details, arguments: student);
              },
              onLongPress: () => _confirmDelete(context, student),
            ),
          );
        },
      ),
    );
  }
void _showManageDialog(BuildContext context) {

  final vm = context.read<StudentViewModel>();

  showModalBottomSheet(
    context: context,

    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25),
      ),
    ),

    builder: (context) {

      return Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            
            mainAxisSize: MainAxisSize.max,
          
            children: [
          
              const Text(
                "Manage Applications",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
          
              const SizedBox(height: 20),
          
              // SORT A-Z
              ListTile(
          
                leading: const Icon(
                  Icons.sort_by_alpha,
                  color: Color(0xFF0B1F8F),
                ),
          
                title: const Text("Sort A - Z"),
          
                onTap: () {
          
                  vm.allPersons.sort(
                    (a, b) => a.name.compareTo(b.name),
                  );
          
                  vm.notifyListeners();
          
                  Navigator.pop(context);
                },
              ),
          
              // SORT Z-A
              ListTile(
          
                leading: const Icon(
                  Icons.sort_by_alpha,
                  color: Colors.red,
                ),
          
                title: const Text("Sort Z - A"),
          
                onTap: () {
          
                  vm.allPersons.sort(
                    (a, b) => b.name.compareTo(a.name),
                  );
          
                  vm.notifyListeners();
          
                  Navigator.pop(context);
                },
              ),
          
              // OLDEST FIRST
              ListTile(
          
                leading: const Icon(
                  Icons.history,
                  color: Colors.orange,
                ),
          
                title: const Text("Oldest Applications"),
          
                onTap: () {
          
                  vm.allPersons.sort(
                  (a, b) => (b.createdAt ?? DateTime.now())
              .compareTo(a.createdAt ?? DateTime.now())
                  );
          
                  vm.notifyListeners();
          
                  Navigator.pop(context);
                },
              ),
          
              // LATEST FIRST
              ListTile(
          
                leading: const Icon(
                  Icons.access_time,
                  color: Colors.green,
                ),
          
                title: const Text("Latest Applications"),
          
                onTap: () {
          
                  vm.allPersons.sort(
                  (a, b) => (a.createdAt ?? DateTime.now())
              .compareTo(b.createdAt ?? DateTime.now())
                  );
          
                  vm.notifyListeners();
          
                  Navigator.pop(context);
                },
              ),
          
              // APPROVED FIRST
              ListTile(
          
                leading: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
          
                title: const Text("Approved First"),
          
                onTap: () {
          
                  vm.allPersons.sort(
                    (a, b) => a.status.compareTo(b.status),
                  );
          
                  vm.notifyListeners();
          
                  Navigator.pop(context);
                },
              ),
          
              // DELETE OPTION
              ListTile(
          
                leading: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
          
                title: const Text("Delete Applications"),
          
                onTap: () {
          
                  Navigator.pop(context);
          
                  showDialog(
                    context: context,
          
                    builder: (dialogContext) {
          
                      return AlertDialog(
          
                        title: const Text(
                          "Delete Application",
                        ),
          
                        content: SizedBox(
                          width: double.maxFinite,
                          height: 300,
          
                          child: ListView.builder(
          
                            itemCount: vm.allPersons.length,
          
                            itemBuilder: (context, index) {
          
                              final student =
                                  vm.allPersons[index];
          
                              return ListTile(
          
                                title: Text(
                                  student.course,
                                ),
          
                                subtitle: Text(
                                  "${student.name} ${student.surname}",
                                ),
          
                                trailing: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
          
                                onTap: () async {
          
                                  Navigator.pop(dialogContext);
          
                                  await vm.deleteStudent(
                                    student.id!,
                                  );
          
                                  if (mounted) {
          
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Application Deleted",
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ),
          
                        actions: [
          
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext);
                            },
          
                            child: const Text("Close"),
                          ),
                        ],
                      );
                    },
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

  void _confirmDelete(BuildContext context, StudentApplication student) {
    
    final scaffoldContext = context;
    
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete Application"),
        content: Text("Delete ${student.name} ${student.surname}'s application?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext), 
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
 
              Navigator.pop(dialogContext);
              
              if (student.id != null) {

                await scaffoldContext.read<StudentViewModel>().deleteStudent(student.id!);
                

                if (mounted) {
                  ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                    const SnackBar(content: Text("Application deleted")),
                  );
                }
              }
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}