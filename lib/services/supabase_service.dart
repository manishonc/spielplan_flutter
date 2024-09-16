import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'edge_functions_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;
  final EdgeFunctionsService _edgeFunctionsService = EdgeFunctionsService();

  Future<AuthResponse> signUp(String email, String password) async {
    return await client.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signIn(String email, String password) async {
    final response =
        await client.auth.signInWithPassword(email: email, password: password);

    if (response.user != null) {
      // Call the post_user_login edge function
      final postUserResponse = await _edgeFunctionsService.postUserLogin();
      print('Post user login response: $postUserResponse');
    }

    return response;
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

  User? getCurrentUser() {
    return client.auth.currentUser;
  }

  Future<AuthResponse> signInWithOAuth(OAuthProvider provider) async {
    final host = await getCurrentHost();
    final redirectUrl =
        kIsWeb ? '${host}auth-callback' : '$host://reset-callback/';

    await client.auth.signInWithOAuth(
      provider,
      redirectTo: redirectUrl,
    );

    return AuthResponse(session: client.auth.currentSession);
  }
}

Future<String> getCurrentHost() async {
  if (kIsWeb) {
    final uri = Uri.base;
    return '${uri.scheme}://${uri.host}/';
  } else {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }
}
