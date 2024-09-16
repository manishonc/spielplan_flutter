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
      return '${uri.scheme}://${uri.host}/';
    } else {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return packageInfo.packageName;
    }
  }

  Future<dynamic> postUserLogin() async {
    final currentDomain = await getCurrentHost();
    final res = await supabase.functions.invoke(
      'post_user_login',
      body: {'customer_domain': currentDomain},
    );
    return res.data;
  }

  // Add other edge function calls here
}
