import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:mercatura/config/api_config.dart';

Future<dynamic> logout(CookieRequest request) async {
  return await request.post("$apiUrl/auth/logout/", {});
}