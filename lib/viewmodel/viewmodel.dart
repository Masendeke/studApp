//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_assistant_application/services/supabase_services.dart';
//import 'package:student_assistant_application/services/supabase_services.dart';
import '../services/storage_service.dart';
import '../views/search_screens.dart';
import '../model/model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';


class StudentViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  final StorageService _storageService = StorageService();
  
  // Form controllers
  final formKey = GlobalKey<FormState>();
  final stdNo = TextEditingController();
  final name = TextEditingController();
  final surname = TextEditingController();
  final email = TextEditingController();
  final course = TextEditingController();
  final year = TextEditingController();
  final module = TextEditingController();

  // Data
  List<StudentApplication> allPersons = [];
  List<StudentApplication> searchResults = [];
  String _query = '';
  StudentApplication? selectedPerson;
  
  // State
  bool isLoading = false;
  String? errorMessage;
  File? selectedImage;
  bool isUploading = false;

  //  DATA METHODS (Call SupabaseService)
  
  Future<void> fetchAllStudents() async {
    isLoading = true;
    notifyListeners();

    try {
      allPersons = await _supabaseService.fetchAllStudents();
      searchResults = allPersons;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUserStudents(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      allPersons = await _supabaseService.fetchUserStudents(userId);
      searchResults = allPersons;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addStudent(StudentApplication student) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        errorMessage = "User not logged in";
        return false;
      }

      final now = DateTime.now();
      final data = {
        'user_id': user.id,
        'std_no': student.stdNo,
        'name': student.name,
        'surname': student.surname,
        'email': student.email,
        'course': student.course,
        'year_of_study': student.yearOfStudy,
        'module1': student.module1,
        'module2': student.module2,
        'status': 'Pending',
        'phone': student.phone,
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      };

      
    await _supabaseService.addStudent(data); 
    await fetchAllStudents();
    return true;
  } catch (e) {
    errorMessage = e.toString();
    return false;
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

  Future<void> deleteStudent(String id) async {
    try {
      await _supabaseService.deleteStudent(id);
      await fetchAllStudents();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> approveApplication(String id) async {
    try {
      await _supabaseService.approveApplication(id);
      await fetchAllStudents();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> rejectApplication(String id) async {
    try {
      await _supabaseService.rejectApplication(id);
      await fetchAllStudents();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> refreshData() async {
    await fetchAllStudents();
  }

  // IMAGE METHODS (Call StorageService) 
  
  Future<void> pickImage(ImageSource source) async {
    final image = await StorageService.pickImage(source);
    if (image != null) {
      selectedImage = image;
      notifyListeners();
    }
  }

  Future<String?> uploadProfilePicture(String studentId) async {
    if (selectedImage == null) return null;
    
    isUploading = true;
    notifyListeners();
    
    try {
      final imageUrl = await _storageService.uploadProfilePicture(studentId, selectedImage!);
      return imageUrl;
    } catch (e) {
      errorMessage = e.toString();
      return null;
    } finally {
      isUploading = false;
      notifyListeners();
    }
  }

  //  SEARCH METHODS 
  
  void search(String query) {
    _query = query;
    if (_query.isEmpty) {
      searchResults = allPersons;
    } else {
      searchResults = allPersons.where((person) =>
        person.name.toLowerCase().contains(_query.toLowerCase()) ||
        person.surname.toLowerCase().contains(_query.toLowerCase()) ||
        person.email.toLowerCase().contains(_query.toLowerCase()) ||
        person.stdNo.toLowerCase().contains(_query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

  void showSearchDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => const SearchDialog());
  }

  void selectPerson(StudentApplication person) {
    selectedPerson = person;
    notifyListeners();
  }

  void clearSearch() {
    _query = '';
    searchResults = allPersons;
    notifyListeners();
  }

  // COUNTERS 
  
  int get totalStudentCount => allPersons.length;
  int get pendingCount => allPersons.where((p) => p.status == 'Pending').length;
  int get approvedCount => allPersons.where((p) => p.status == 'Approved').length;
  int get rejectedCount => allPersons.where((p) => p.status == 'Rejected').length;


  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return const Color(0xFF0B1F8F);
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}