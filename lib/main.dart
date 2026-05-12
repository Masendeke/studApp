//224043099 Masendeke CP
//224014647 Mahlangu P
//224125791 Khunyeli P
//224081629 Ntlati TT
//224083089 Tshabane L
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_assistant_application/routes/app_routes.dart';
import 'package:student_assistant_application/viewmodel/auth_viewmodel.dart';
import 'package:student_assistant_application/views/application_form_screen.dart';
//import 'package:student_assistant_application/views/edit_application_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:student_assistant_application/viewmodel/viewmodel.dart';
import 'views/auth_wrapper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://irpvuuxxrctobbrqwrag.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlycHZ1dXh4cmN0b2JicnF3cmFnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzgzNDkyMzUsImV4cCI6MjA5MzkyNTIzNX0.Vymlt-27UUEklDXWuYXXocdI2PZ4JZ2d9fL0z-ctNLY',
    );
  runApp(const MyApp());}
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
        home: const AuthWrapper(),
        routes: {
    AppRoutes.apply: (context) =>
        const Applicationformscreen(),

  //   AppRoutes.editApplication: (context) =>
  //       const EditApplicationScreen(),
  },

      ),
    );
  }
}
