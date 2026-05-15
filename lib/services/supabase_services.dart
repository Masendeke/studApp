/*
*Student Numbers:224043099, 224014647, 224125791, 224081629, 224083089
*Student Names  : Masendeke Chiedza P, Mahlangu Phindile, Khunyeli Paballo, Ntlati Thembinkosi T, Tshabane Lonwabo
*Question : SupabaseService 
*/
// Database operations for Supabase
import 'package:supabase_flutter/supabase_flutter.dart';
import '../model/model.dart';

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;
  static const String _tableName = 'student_applications';

  //  READ all students (for Admin) 
  Future<List<StudentApplication>> fetchAllStudents() async {
    try {
      final response = await _supabase
          .from(_tableName)
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => StudentApplication.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch students: $e');
    }
  }

  //  READ students for specific user 
  Future<List<StudentApplication>> fetchUserStudents(String userId) async {
    try {
      final response = await _supabase
          .from(_tableName)
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => StudentApplication.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch user students: $e');
    }
  }

  //  CREATE new student application 
  Future<void> addStudent(Map<String, dynamic> studentData) async {
  try {
    await _supabase.from('students').insert(studentData);
  } catch (e) {
    throw Exception('Failed to add student: $e');
  }
}

  // UPDATE student application 
  Future<void> updateStudent(String id, Map<String, dynamic> updateData) async {
    try {
      await _supabase
          .from(_tableName)
          .update(updateData)
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to update student: $e');
    }
  }

  //  DELETE student application 
  Future<void> deleteStudent(String id) async {
    try {
      await _supabase.from(_tableName).delete().eq('id', id);
    } catch (e) {
      throw Exception('Failed to delete student: $e');
    }
  }

  //  APPROVE application 
  Future<void> approveApplication(String id) async {
    try {
      await _supabase
          .from(_tableName)
          .update({
            'status': 'Approved',
            'updated_at': DateTime.now().toIso8601String()
          })
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to approve application: $e');
    }
  }

  //  REJECT application 
  Future<void> rejectApplication(String id) async {
    try {
      await _supabase
          .from(_tableName)
          .update({
            'status': 'Rejected',
            'updated_at': DateTime.now().toIso8601String()
          })
          .eq('id', id);
    } catch (e) {
      throw Exception('Failed to reject application: $e');
    }
  }

  //  SEARCH students 
  Future<List<StudentApplication>> searchStudents(String query) async {
    if (query.isEmpty) return [];
    
    try {
      final response = await _supabase
          .from(_tableName)
          .select()
          .or(
            'name.ilike.%$query%,'
            'surname.ilike.%$query%,'
            'email.ilike.%$query%,'
            'std_no.ilike.%$query%'
          )
          .order('created_at', ascending: false);
      return (response as List)
          .map((json) => StudentApplication.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Search failed: $e');
    }
  }
}