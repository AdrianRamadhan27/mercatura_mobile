import 'package:mercatura/models/umkm.dart';
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
  return response.map<Umkm>((record) => Umkm.fromJson(record)).toList().where((record) => (record.fields.namaUsaha.contains(search_query)
      && record.fields.bidangUsaha.contains(bidang_usaha)
      && record.fields.lokasiUsaha.contains(lokasi_usaha))).toList();
}

