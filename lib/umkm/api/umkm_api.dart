import 'package:mercatura/umkm/models/umkm.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'package:mercatura/config/api_config.dart';

Future<List<Umkm>> fetchUmkmList(CookieRequest request, String search_query, String bidang_usaha, String lokasi_usaha) async {

  final response = await request.get("$apiUrl/umkm/json/");
  if (bidang_usaha == "Semua"){
    bidang_usaha = "";
  }
  if (lokasi_usaha == "Semua") {
    lokasi_usaha = "";
  }
  return response.map<Umkm>((record) => Umkm.fromJson(record)).toList().where((record) => (record.fields.namaUsaha.toLowerCase().contains(search_query.toLowerCase())
      && record.fields.bidangUsaha.contains(bidang_usaha)
      && record.fields.lokasiUsaha.contains(lokasi_usaha))).toList();
}

Future<Umkm> fetchUmkmDetail(CookieRequest request, int id) async {

  final response = await request.get("$apiUrl/umkm/detail_json/$id");
  return response.map<Umkm>((record) => Umkm.fromJson(record)).toList()[0];
}

