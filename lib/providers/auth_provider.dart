import 'package:flutter/foundation.dart';
import '../models/auth_state.dart';
import '../services/supabase_service.dart';

class AuthProvider with ChangeNotifier {
  AuthState _authState = AuthState.initial();
  final SupabaseService _supabaseService = SupabaseService();

  AuthState get authState => _authState;

  Future<void> signIn(String email, String password) async {
    try {
      final response = await _supabaseService.signIn(email, password);
      if (response.user != null) {
        _authState = AuthState.authenticated();
      } else {
        _authState = AuthState.unauthenticated('Sign in failed');
      }
    } catch (e) {
      _authState = AuthState.unauthenticated(e.toString());
    }
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    try {
      final response = await _supabaseService.signUp(email, password);
      if (response.user != null) {
        _authState = AuthState.authenticated();
      } else {
        _authState = AuthState.unauthenticated('Sign up failed');
      }
    } catch (e) {
      _authState = AuthState.unauthenticated(e.toString());
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _supabaseService.signOut();
    _authState = AuthState.unauthenticated();
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    final user = _supabaseService.getCurrentUser();
    if (user != null) {
      _authState = AuthState.authenticated();
    } else {
      _authState = AuthState.unauthenticated();
    }
    notifyListeners();
  }
}
