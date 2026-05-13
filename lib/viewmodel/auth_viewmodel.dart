//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L
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

  Future<bool> signUp(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
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

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
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