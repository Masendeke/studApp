//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/model.dart';

class StudentViewModel extends ChangeNotifier {

  final SupabaseClient _supabase =
      Supabase.instance.client;

  List<StudentApplication> students = [];
  List<StudentApplication> searchResults = [];

  bool isLoading = false;
  String? errorMessage;

  // FETCH STUDENTS (USER ONLY)
  Future<void> fetchStudents() async {

    isLoading = true;
    notifyListeners();

    try {

      final userId = _supabase.auth.currentUser?.id;

      if (userId == null) {
        students = [];
        searchResults = [];
        isLoading = false;
        notifyListeners();
        return;
      }

      final response = await _supabase
          .from('students')
          .select()
          .eq('user_id', userId);

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
    errorMessage = null;
    notifyListeners();

    try {

      final userId = _supabase.auth.currentUser?.id;

      if (userId == null) {
        errorMessage = "User not logged in";
        return false;
      }

      final now = DateTime.now();

      final data = {
        'user_id': userId,
        'std_no': student.stdNo,
        'name': student.name,
        'surname': student.surname,
        'email': student.email,
        'course': student.course,
        'year_of_study': student.yearOfStudy,
        'module1': student.module1,
        'module2': student.module2,
        'status': student.status,
        'phone': student.phone,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      await _supabase.from('students').insert(data);

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

    try {

      await _supabase
          .from('students')
          .delete()
          .eq('id', id);

      await fetchStudents();

    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  // SEARCH
  void search(String query) {

    if (query.isEmpty) {
      searchResults = students;
    } else {

      final q = query.toLowerCase();

      searchResults = students.where((student) {
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