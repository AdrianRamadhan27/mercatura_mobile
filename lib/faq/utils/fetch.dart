import 'package:mercatura/faq/models/faq.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

import 'package:mercatura/config/api_config.dart';


Future<List<Faq>> fetchFaq(CookieRequest request) async {

  final response = await request.get("$apiUrl/faq/json/");
  return response.map<Faq>((record) => Faq.fromJson(record)).toList();
}
