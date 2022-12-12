import 'package:http/http.dart' as http;
import '../models/kritiksaran.dart';
import 'dart:convert';

Future<List<KritikSaran>> fetchKritikSaran() async {
    var url = Uri.parse('https://mercatura-id.up.railway.app/');
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