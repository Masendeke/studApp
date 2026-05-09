
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
    showDialog(
      context: context,
      builder: (_) => const SearchDialog(),
    );
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
  

  void submitApplication()  {
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
  List<StudentApplication> get _searchResults => searchResults;
  String get query => _query;
  bool get hasResults => _searchResults.isNotEmpty;
  bool get isSearching => _query.isNotEmpty;



}



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
