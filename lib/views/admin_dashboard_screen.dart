import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/viewmodel.dart';


class Admindashboardscreen extends StatelessWidget {
  const Admindashboardscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Admin Dashboard',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(height: 1, color: Colors.grey.shade200),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () => vm.showSearchDialog(context),
              ),
              IconButton(icon: const Icon(Icons.more_vert, color: Colors.black,), onPressed: () {}),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Stat cards row 1 ---
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Column(
                          children: [
                            Icon(Icons.people, color: Colors.blue),
                            //Varible -length of  totalApps,e.g. vm.apps
                            Text('TOTAL APPS'),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                    Expanded(
                      child: Card(
                        child: Column(
                          children: [
                            Icon(Icons.access_time, color: Colors.grey),
                            //Varible -length of pending apps,e.g. vm.pending
                            Text('PENDING'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // --- Stat cards row 2 ---
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        child: Column(
                          children: [
                            Icon(Icons.check, color: Colors.green),
                            //Varible - length of approved apps,
                            Text('APPROVED'),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),
                    Expanded(
                      child: Card(
                        child: Column(
                          children: [
                            Icon(Icons.error_outline, color: Colors.red),
                            //Varible -  length of rejected apps e.g. vm.rejected
                            Text('REJECTED '),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                /**
                     * filter button
                     */
                const SizedBox(height: 16),

                // --- Recent applications header ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'RECENT APPLICATIONS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade600,
                        letterSpacing: 0.8,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 12,
                          color:  Color(0xFF4A90D9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // --- Application list ---
              ],
            ),
          ),
        );
      },
    );
  }
}
