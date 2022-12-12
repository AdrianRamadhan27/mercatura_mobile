import 'package:mercatura/umkm/models/umkm.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';


import 'package:mercatura/config/api_config.dart';

Future<List<Umkm>> fetchUmkmList(CookieRequest request, String searchQuery, String bidangUsaha, String lokasiUsaha) async {

  final response = await request.get("$apiUrl/umkm/json/");
  if (bidangUsaha == "Semua"){
    bidangUsaha = "";
  }
  if (lokasiUsaha == "Semua") {
    lokasiUsaha = "";
  }
  return response.map<Umkm>((record) => Umkm.fromJson(record)).toList().where((record) => (record.fields.namaUsaha.toLowerCase().contains(searchQuery.toLowerCase())
      && record.fields.bidangUsaha.contains(bidangUsaha)
      && record.fields.lokasiUsaha.contains(lokasiUsaha))).toList();
}

Future<Umkm> fetchUmkmDetail(CookieRequest request, int id) async {

  final response = await request.get("$apiUrl/umkm/detail_json/$id");
  return response.map<Umkm>((record) => Umkm.fromJson(record)).toList()[0];
}

