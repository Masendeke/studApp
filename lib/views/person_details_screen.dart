//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081442 Nlati TT
//224083089 Tshabane L
// lib/views/person_details_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../model/model.dart';

class PersonDetailsScreen extends StatelessWidget {
  final StudentApplication person;

  const PersonDetailsScreen({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '${person.name} ${person.surname}',
          style: const TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(person.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  person.status.toUpperCase(),
                  style: TextStyle(
                    color: _getStatusColor(person.status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Student Info Card
            _buildInfoCard(),
            const SizedBox(height: 16),

            // Modules Card
            _buildModulesCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Student Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(), //adds line under the header
            const SizedBox(height: 8),
            _buildInfoRow(Icons.numbers, 'Student Number', person.stdNo),
            _buildInfoRow(
              Icons.person,
              'Name',
              '${person.name} ${person.surname}',
            ),
            _buildInfoRow(Icons.email, 'Email', person.email),
            _buildInfoRow(Icons.school, 'Course', person.course),
            _buildInfoRow(
              Icons.calendar_today,
              'Year of Study',
              person.yearOfStudy,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModulesCard() {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Modules',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            _buildInfoRow(Icons.book, 'Module 1', person.module1),
            _buildInfoRow(Icons.book, 'Module 2', person.module2),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Color(0xFF0B1F8F);
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
