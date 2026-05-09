//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081442 Nlati TT
//224083089 Tshabane L
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/viewmodel.dart';
import '../model/model.dart';
import '../views/person_details_screen.dart';

class Admindashboardscreen extends StatelessWidget {
  const Admindashboardscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentViewModel>(
      builder: (context, vm, _) {
        // Load mock data if empty
        if (vm.allPersons.isEmpty) {
          vm.loadPersons(vm.getMockData());
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0B1F8F), // Dark blue at top
                  Color(0xFF1976D2), // Medium blue
                  Colors.white, // White at bottom
                ],
              ),
            ),
            child: Scaffold(
              backgroundColor:
                  Colors.transparent, // Make inner Scaffold transparent
              appBar: AppBar(
                title: const Text(
                  'Admin Dashboard',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.transparent, // Make AppBar transparent
                foregroundColor: Colors.black,
                elevation: 0,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1),
                  child: Container(height: 1, color: Colors.grey.shade200),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.black),
                    onPressed: () {},
                  ),
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
                          child: _buildStatCard(
                            icon: Icons.people,
                            iconColor: Colors.blue,
                            value: vm.totalStudentCount.toString(),
                            label: 'TOTAL APPS',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildStatCard(
                            icon: Icons.access_time,
                            iconColor: Colors.orange,
                            value: vm.pendingCount.toString(),
                            label: 'PENDING',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // --- Stat cards row 2 ---
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            icon: Icons.check_circle,
                            iconColor: Color(0xFF1976D2),
                            value: vm.approvedCount.toString(),
                            label: 'APPROVED',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _buildStatCard(
                            icon: Icons.cancel,
                            iconColor: Colors.red,
                            value: vm.rejectedCount.toString(),
                            label: 'REJECTED',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    const SizedBox(height: 16),

                    // --- Recent applications header ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'RECENT APPLICATIONS',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            vm.showSearchDialog(context);
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.black,
                          ),
                          label: const Text(
                            'Search Students',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // --- Application list ---
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: vm.allPersons.length,
                      itemBuilder: (context, index) {
                        final student = vm.allPersons[index];
                        return _buildApplicationCard(context, vm, student);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String label,
  }) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApplicationCard(
    BuildContext context,
    StudentViewModel vm,
    StudentApplication student,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  backgroundColor: vm
                      .getStatusColor(student.status)
                      .withOpacity(0.1),
                  child: Text(
                    student.name[0].toUpperCase(),
                    style: TextStyle(
                      color: vm.getStatusColor(student.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Student Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${student.name} ${student.surname}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        student.stdNo,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            size: 12,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              student.email,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status Chip
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: vm.getStatusColor(student.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    student.status.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: vm.getStatusColor(student.status),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //  Buttons (only if status is pending)
          if (student.status == 'Pending')
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  // Details Button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PersonDetailsScreen(person: student),
                          ),
                        );
                      },
                      icon: const Icon(Icons.info_outline, size: 18),
                      label: const Text('Details'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.blue),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Approve Button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showConfirmDialog(
                        context,
                        'Approve',
                        student,
                        () => vm.approveApplication(student.stdNo),
                      ),
                      icon: const Icon(Icons.check_circle, size: 18),
                      label: const Text('Approve'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Reject Button
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showConfirmDialog(
                        context,
                        'Reject',
                        student,
                        () => vm.rejectApplication(student.stdNo),
                      ),
                      icon: const Icon(Icons.cancel, size: 18),
                      label: const Text('Reject'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // For approved/rejected - only show Details button
          if (student.status != 'Pending')
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PersonDetailsScreen(person: student),
                          ),
                        );
                      },
                      icon: const Icon(Icons.info_outline, size: 18),
                      label: const Text('View Details'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        side: const BorderSide(color: Colors.blue),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showConfirmDialog(
    BuildContext context,
    String action,
    StudentApplication student,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          '$action Application',
          style: const TextStyle(color: Colors.black87),
        ),
        content: Text(
          'Are you sure you want to ${action.toLowerCase()} ${student.name} ${student.surname}\'s application?',
          style: const TextStyle(color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Application ${action.toLowerCase()}d'),
                  backgroundColor: action == 'Approve'
                      ? Color(0xFF1976D2)
                      : Colors.red,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Text(
              action,
              style: TextStyle(
                color: action == 'Approve' ? Color(0xFF1976D2) : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
