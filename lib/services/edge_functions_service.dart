import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EdgeFunctionsService {
  static final EdgeFunctionsService _instance =
      EdgeFunctionsService._internal();
  factory EdgeFunctionsService() => _instance;
  EdgeFunctionsService._internal();

  final supabase = Supabase.instance.client;

  Future<String> getCurrentHost() async {
    if (kIsWeb) {
      final uri = Uri.base;
      if (uri.host == 'localhost') {
        return '${uri.host}:${uri.port}';
      }
      return uri.host;
    } else {
      // For non-web platforms, we'll use the package name as before
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.packageName;
    }
  }

  Future<dynamic> postUserLogin() async {
    final currentDomain = await getCurrentHost();
    //final currentDomain = 'spielplan.io';
    print('Calling post_user_login with domain: $currentDomain');
    try {
      final res = await supabase.functions.invoke(
        'post_user_login',
        body: {'customer_domain': currentDomain},
      );
      print('post_user_login response: ${res.data}');
      return res.data;
    } catch (e) {
      print('Error in post_user_login: $e');
      rethrow;
    }
  }

  // Add other edge function calls here
}
