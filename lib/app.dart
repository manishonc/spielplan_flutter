import 'package:flutter/material.dart';
import 'package:spielplan/screens/auth/auth_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home_screen.dart';
import 'services/supabase_service.dart';

class MyApp extends StatelessWidget {
  final SupabaseService _supabaseService = SupabaseService();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spielplan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute:
          _supabaseService.getCurrentUser() != null ? '/home' : '/login',
      routes: {
        '/login': (context) => const AuthScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
