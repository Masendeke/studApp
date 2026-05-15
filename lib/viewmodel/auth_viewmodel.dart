/*
*Student Numbers:224043099, 224014647, 224125791, 224081629, 224083089
*Student Names  : Masendeke Chiedza P, Mahlangu Phindile, Khunyeli Paballo, Ntlati Thembinkosi T, Tshabane Lonwabo
*Question : AuthViewModel
*/
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthViewModel extends ChangeNotifier {
  final SupabaseClient _supabase = Supabase.instance.client;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _supabase.auth.currentSession != null;
  String? get currentUserEmail => _supabase.auth.currentUser?.email;
  String? get currentUserId => _supabase.auth.currentUser?.id;

  //  CUT EMAIL VALIDATION
  bool _isValidCutEmail(String email) {
    final regex = RegExp(r'^\d{9}@stud\.cut\.ac\.za$');
    return regex.hasMatch(email);
  }

  String _friendlyError(String error) {
    final msg = error.toLowerCase();

    if (msg.contains("invalid login credentials")) {
      return "Incorrect email or password. Please try again.";
    }

    if (msg.contains("email not confirmed")) {
      return "Please verify your email before logging in.";
    }

    if (msg.contains("user already registered")) {
      return "This email is already registered. Try logging in instead.";
    }

    if (msg.contains("network")) {
      return "No internet connection. Please check your network.";
    }

    if (msg.contains("too many requests")) {
      return "Too many attempts. Please wait a few minutes.";
    }

    return "Something went wrong. Please try again.";
  }

  //  SIGN UP
  Future<bool> signUp(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (!_isValidCutEmail(email)) {
        _errorMessage =
            "Only CUT student emails allowed (e.g. 224043099@stud.cut.ac.za)";
        return false;
      }

      final response = await _supabase.auth.signUp(
        email: email.trim(),
        password: password,
      );

      if (response.user == null) {
        _errorMessage = "Sign up failed. Please try again.";
        return false;
      }

      return true;
    } catch (e) {
      _errorMessage = _friendlyError(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //  SIGN IN (your original method FIXED)
  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (!_isValidCutEmail(email)) {
        _errorMessage =
            "Only CUT student emails allowed (e.g. 224043099@stud.cut.ac.za)";
        return false;
      }

      final response = await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      if (response.user == null) {
        _errorMessage = "Login failed. Please try again.";
        return false;
      }

      return true;
    } catch (e) {
      _errorMessage = _friendlyError(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

 
  Future<String?> login(String email, String password) async {
    final success = await signIn(email, password);
    return success ? null : _errorMessage;
  }

  //  SIGN OUT
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      _errorMessage = "Could not sign out. Please try again.";
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}