import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/model.dart';

class StudentViewModel extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  List<StudentApplication> students = [];
  List<StudentApplication> searchResults = [];

  bool isLoading = false;
  String? errorMessage;

  // FETCH STUDENTS
  Future<void> fetchStudents() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await _supabase.from('students').select();

      students = (response as List)
          .map((json) => StudentApplication.fromJson(json))
          .toList();

      searchResults = students;
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  // ADD STUDENT
  Future<bool> addStudent(StudentApplication student) async {
    isLoading = true;
    notifyListeners();

    try {
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

      await _supabase.from('students').insert(newStudent.toJson());

      await fetchStudents();
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // DELETE STUDENT
  Future<void> deleteStudent(String id) async {
    await _supabase.from('students').delete().eq('id', id);
    await fetchStudents();
  }

  // SEARCH
  void search(String query) {
    if (query.isEmpty) {
      searchResults = students;
    } else {
      searchResults = students.where((student) {
        final q = query.toLowerCase();

        return student.name.toLowerCase().contains(q) ||
            student.surname.toLowerCase().contains(q) ||
            student.email.toLowerCase().contains(q) ||
            student.stdNo.toLowerCase().contains(q);
      }).toList();
    }

    notifyListeners();
  }

  // CLEAR SEARCH
  void clearSearch() {
    searchResults = students;
    notifyListeners();
  }
}