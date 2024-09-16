import 'package:flutter/material.dart';
import 'package:spielplan/services/supabase_service.dart';
import 'package:spielplan/utils/auth_utils.dart';

class HomeScreen extends StatelessWidget {
  final SupabaseService _supabaseService = SupabaseService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = _supabaseService.getCurrentUser();

    // If user is not logged in, redirect to login screen
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed('/login');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Spielplan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => AuthUtils.handleLogout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome!', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Text('User ID: ${user.id}'),
            const SizedBox(height: 20),
            Text('Email: ${user.email}'),
          ],
        ),
      ),
    );
  }
}
