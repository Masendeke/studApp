//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/model.dart';

<<<<<<< HEAD
class StudentViewModel extends ChangeNotifier {

  final SupabaseClient _supabase =
      Supabase.instance.client;
=======
class StudentViewModel extends ChangeNotifier {//this class is used to manage the state of the application and also to manage the data of the application and also to manage the logic of the application and also to manage the communication with the database and also to manage the communication with the storage service
  final SupabaseClient _supabase = Supabase.instance.client;
>>>>>>> main

// State variables
  List<StudentApplication> students = [];
  List<StudentApplication> searchResults = [];
// Loading and error states
  bool isLoading = false;
  String? errorMessage;

  // FETCH STUDENTS (USER ONLY)
  Future<void> fetchStudents() async {

    isLoading = true;
    notifyListeners();

<<<<<<< HEAD
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

=======
    try {// Fetch all student applications from the database
      final response = await _supabase.from('students').select();
// Parse the response into a list of StudentApplication objects
>>>>>>> main
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
    errorMessage = null;
    notifyListeners();

<<<<<<< HEAD
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

=======
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
>>>>>>> main
      await fetchStudents();
      return true;

    } catch (e) {
      errorMessage = e.toString();
      return false;
<<<<<<< HEAD

    } finally {
=======
    } finally {// Update loading state
>>>>>>> main
      isLoading = false;
      notifyListeners();
    }
  }

  // DELETE STUDENT
<<<<<<< HEAD
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
=======
  Future<void> deleteStudent(String id) async {// Delete a student application from the database using the provided ID and then refresh the student list
    await _supabase.from('students').delete().eq('id', id);
    await fetchStudents();
>>>>>>> main
  }

  // SEARCH
  void search(String query) {
<<<<<<< HEAD

    if (query.isEmpty) {
      searchResults = students;
    } else {

      final q = query.toLowerCase();

      searchResults = students.where((student) {
=======
    if (query.isEmpty) {// If the search query is empty, show all students
      searchResults = students;
    } else {// Filter the students based on the search query (case-insensitive) and update the search results
      searchResults = students.where((student) {
        final q = query.toLowerCase();

// Check if the student's name, surname, email, or student number contains the search query
>>>>>>> main
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