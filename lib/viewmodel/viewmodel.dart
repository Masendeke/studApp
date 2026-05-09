// ignore_for_file: strict_top_level_inference

import 'package:flutter/material.dart';
import '../views/search_screens.dart';
import '../model/model.dart';

class StudentViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final stdNo = TextEditingController();
  final name = TextEditingController();
  final surname = TextEditingController();
  final email = TextEditingController();
  final course = TextEditingController();
  final year = TextEditingController();
  final module = TextEditingController();

  //search entities
  List<StudentApplication> allPersons = [];
  List<StudentApplication> searchResults = [];
  String _query = '';
  StudentApplication? selectedPerson;

  // Search methods
  void search(String query) {
    _query = query;

    if (_query.isEmpty) {
      searchResults = [];
    } else {
      searchResults = allPersons
          .where(
            (person) =>
                person.name.toLowerCase().contains(_query.toLowerCase()) ||
                person.surname.toLowerCase().contains(_query.toLowerCase()) ||
                person.email.toLowerCase().contains(_query.toLowerCase()) ||
                person.stdNo.toLowerCase().contains(_query.toLowerCase()),
          )
          .toList();
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

  // Clear search
  void clearSearch() {
    _query = '';
    searchResults = [];
    notifyListeners();
  }

  String status = 'Pending';

  void submitApplication() {
    if (formKey.currentState!.validate()) {
      status = 'Submitted';
      notifyListeners();
    }
  }

  // Load fake data
  void loadPersons(List<StudentApplication> persons) {
    allPersons = persons;
    notifyListeners();
  }

  // Getters
  List<StudentApplication> get searchResultsList => searchResults;
  String get query => _query;
  bool get hasResults => searchResults.isNotEmpty;
  bool get isSearching => _query.isNotEmpty;

  //Counters
  int get totalStudentCount => allPersons.length;
  int get pendingCount => allPersons.where((p) => p.status == 'Pending').length;
  int get approvedCount =>
      allPersons.where((p) => p.status == 'Approved').length;
  int get rejectedCount =>
      allPersons.where((p) => p.status == 'Rejected').length;

  //Approve/Rejected methods
  void approveApplication(String stdNo) {
    final index = allPersons.indexWhere((p) => p.stdNo == stdNo);
    if (index != -1) {
      allPersons[index].status = 'Approved';
      notifyListeners();
    }
  }

  void rejectApplication(String stdNo) {
    final index = allPersons.indexWhere((p) => p.stdNo == stdNo);
    if (index != -1) {
      allPersons[index].status = 'Rejected';
      notifyListeners();
    }
  }

  //Status Colors
  Color getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  //fake Data for visual purposes
  //this will be replaced with thr database (API call / supabase)
  List<StudentApplication> getMockData() {
    return [
      StudentApplication(
        stdNo: '223672435',
        name: 'John',
        email: '223672435@gmailcom',
        surname: 'Johns',
        yearOfStudy: '2023',
        course: 'IT',
        module1: 'SOD',
        module2: 'TPG',
        status: 'Pending',
      ),
      StudentApplication(
        stdNo: '224067592',
        name: 'Jane',
        email: 'jane@example.com',
        surname: 'Smith',
        yearOfStudy: '2024',
        course: 'CMN',
        module1: 'SOD',
        module2: 'TPG',
        status: 'Approved',
      ),
      StudentApplication(
        stdNo: '225673421',
        name: 'Bob',
        email: 'bob@example.com',
        surname: 'Johnson',
        yearOfStudy: '2025',
        course: 'CMN',
        module1: 'CMN',
        module2: 'TPG',
        status: 'Rejected',
      ),
      StudentApplication(
        stdNo: '222786902',
        name: 'Alice',
        email: 'alice@example.com',
        surname: 'Brown',
        yearOfStudy: '2025',
        course: 'IT',
        module1: 'SSE',
        module2: 'TPG',
        status: 'Pending',
      ),
      StudentApplication(
        stdNo: '224675893',
        name: 'Charlie',
        email: 'charlie@example.com',
        surname: 'Wilson',
        yearOfStudy: '2026',
        course: 'IT',
        module1: 'SOD',
        module2: 'TPG',
        status: 'Pending',
      ),
      StudentApplication(
        stdNo: '224674011',
        name: 'Diana',
        email: 'diana@example.com',
        surname: 'Prince',
        yearOfStudy: '2026',
        course: 'IT',
        module1: 'SOD',
        module2: 'SOE',
        status: 'Approved',
      ),
      StudentApplication(
        stdNo: '221345876',
        name: 'Keabetsoe',
        email: 'Kea@example.com',
        surname: 'Sekhuthe',
        yearOfStudy: '2024',
        course: 'CMN',
        module1: 'SOD',
        module2: 'SPG',
      ),
    ];
  }

  void refreshData() {
    getMockData(); //when database is being builty make this fetch the data from the database
  }
} //end viewModel

class AuthViewModel extends ChangeNotifier {
  bool loading = false;
  Future<void> login(String email, String password) async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    loading = false;
    notifyListeners();
  }
}
