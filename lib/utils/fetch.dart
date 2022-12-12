import 'package:mercatura/models/kisah.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:mercatura/config/api_config.dart';


Future<List<Kisah>> fetchKisah(CookieRequest request) async {

  final response = await request.get("$apiUrl/json/");
  return response.map<Kisah>((record) => Kisah.fromJson(record)).toList();
}