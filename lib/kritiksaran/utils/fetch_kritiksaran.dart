import 'package:http/http.dart' as http;
import '../models/kritiksaran.dart';
import 'dart:convert';
import '../../core/environments/endpoints.dart';

Future<List<KritikSaran>> fetchKritikSaran() async {
  var url = Uri.parse(Endpoint.kritikSaran);
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // ini namanya sama mungkin konflik lol
  List<KritikSaran> listKritikSaran = [];
  for (var d in data) {
    if (d != null) {
      listKritikSaran.add(KritikSaran.fromJson(d));
    }
  }

  return listKritikSaran;
}
