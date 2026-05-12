import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/model.dart';

class StudentViewModel extends ChangeNotifier {//this class is used to manage the state of the application and also to manage the data of the application and also to manage the logic of the application and also to manage the communication with the database and also to manage the communication with the storage service
  final SupabaseClient _supabase = Supabase.instance.client;

// State variables
  List<StudentApplication> students = [];
  List<StudentApplication> searchResults = [];
// Loading and error states
  bool isLoading = false;
  String? errorMessage;

  // FETCH STUDENTS
  Future<void> fetchStudents() async {
    isLoading = true;
    notifyListeners();

    try {// Fetch all student applications from the database
      final response = await _supabase.from('students').select();
// Parse the response into a list of StudentApplication objects
      students = (response as List)
          .map((json) => StudentApplication.fromJson(json))
          .toList();

      searchResults = students;
    } catch (e) {
      errorMessage = e.toString();
    }
// Update loading state
    isLoading = false;
    notifyListeners();
  }

  // ADD STUDENT
  Future<bool> addStudent(StudentApplication student) async {
    isLoading = true;
    notifyListeners();

    try {// Create a new student application with the current timestamp for createdAt and updatedAt
      final now = DateTime.now();

      final newStudent = StudentApplication(
        id: student.id,
        stdNo: student.stdNo,
        email: student.email,
        name: student.name,
        surname: student.surname,
        yearOfStudy: student.yearOfStudy,
        module1: student.module1,
        module2: student.module2,
        course: student.course,
        phone: student.phone,
        status: student.status,
        createdAt: now,
        updatedAt: now,
      );
// Insert the new student application into the database
      await _supabase.from('students').insert(newStudent.toJson());
// Refresh the student list after adding
      await fetchStudents();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {// Update loading state
      isLoading = false;
      notifyListeners();
    }
  }

  // DELETE STUDENT
  Future<void> deleteStudent(String id) async {// Delete a student application from the database using the provided ID and then refresh the student list
    await _supabase.from('students').delete().eq('id', id);
    await fetchStudents();
  }

  // SEARCH
  void search(String query) {
    if (query.isEmpty) {// If the search query is empty, show all students
      searchResults = students;
    } else {// Filter the students based on the search query (case-insensitive) and update the search results
      searchResults = students.where((student) {
        final q = query.toLowerCase();

// Check if the student's name, surname, email, or student number contains the search query
        return student.name.toLowerCase().contains(q) ||
            student.surname.toLowerCase().contains(q) ||
            student.email.toLowerCase().contains(q) ||
            student.stdNo.toLowerCase().contains(q);
      }).toList();
    }
// Notify listeners to update the UI with the new search results
    notifyListeners();
  }

  // CLEAR SEARCH
  void clearSearch() {// Clear the search results and show all students
    searchResults = students;
    notifyListeners();
  }
}