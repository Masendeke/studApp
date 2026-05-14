/*
*Student Numbers:224043099, 224014647, 224125791, 224081629, 224083089
*Student Names  : Masendeke Chiedza P, Mahlangu Phindile, Khunyeli Paballo, Ntlati Thembinkosi T, Tshabane Lonwabo
*Question :Main 
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:student_assistant_application/routes/app_routes.dart';
import 'package:student_assistant_application/viewmodel/auth_viewmodel.dart';
import 'package:student_assistant_application/viewmodel/viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://xqmsbytonptblftrbgyg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhxbXNieXRvbnB0YmxmdHJiZ3lnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg2NzQ3NjMsImV4cCI6MjA5NDI1MDc2M30.kI39H3CAORcqfXdUCL5SH-MLMWnEjKdLB0WAqRXSRcI',
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => StudentViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Student Assistant App',
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}