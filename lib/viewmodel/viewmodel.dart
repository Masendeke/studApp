import 'package:flutter/material.dart';
class StudentViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final stdNo = TextEditingController();
  final name = TextEditingController();
  final surname = TextEditingController();
  final email = TextEditingController();
  final course = TextEditingController();
  final year = TextEditingController();
  final module = TextEditingController();

  String status = 'Pending';

  void submitApplication() {
    if (formKey.currentState!.validate()) {
      status = 'Submitted';
      notifyListeners();
    }
  }
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
