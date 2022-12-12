// To parse this JSON data, do
//
//     final umkm = umkmFromJson(jsonString);

import 'dart:convert';

List<Umkm> umkmFromJson(String str) => List<Umkm>.from(json.decode(str).map((x) => Umkm.fromJson(x)));

String umkmToJson(List<Umkm> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Umkm {
  Umkm({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Umkm.fromJson(Map<String, dynamic> json) => Umkm(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  Fields({
    required this.namaUsaha,
    required this.bidangUsaha,
    required this.deskripsiUsaha,
    required this.emailUsaha,
    required this.lokasiUsaha,
    required this.websiteUsaha,
    required this.logoUsaha,
    required this.pemilikUsaha,
  });

  String namaUsaha;
  String bidangUsaha;
  String deskripsiUsaha;
  String emailUsaha;
  String lokasiUsaha;
  String websiteUsaha;
  String logoUsaha;
  String pemilikUsaha;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    namaUsaha: json["nama_usaha"],
    bidangUsaha: json["bidang_usaha"],
    deskripsiUsaha: json["deskripsi_usaha"],
    emailUsaha: json["email_usaha"],
    lokasiUsaha: json["lokasi_usaha"],
    websiteUsaha: json["website_usaha"],
    logoUsaha: json["logo_usaha"],
    pemilikUsaha: json["pemilik_usaha"],
  );

  Map<String, dynamic> toJson() => {
    "nama_usaha": namaUsaha,
    "bidang_usaha": bidangUsaha,
    "deskripsi_usaha": deskripsiUsaha,
    "email_usaha": emailUsaha,
    "lokasi_usaha": lokasiUsaha,
    "website_usaha": websiteUsaha,
    "logo_usaha": logoUsaha,
    "pemilik_usaha": pemilikUsaha,
  };
}

final List<String> daftarBidang = [
  "Agribisnis",
  "Kuliner",
  "Fashion"
];

final List<String> daftarProvinsi = [
  'Aceh',
  'Sumatera Utara',
  'Sumatera',
  'Riau',
  'Jambi',
  'Sumatera Selatan',
  'Bengkulu',
  'Lampung',
  'Kepulauan Bangka Belitung',
  'Kepulauan Riau',
  'DKI Jakarta',
  'Jawa Barat',
  'Jawa Tengah',
  'DI Yogyakarta',
  'Jawa Timur',
  'Banten',
  'Bali',
  'Nusa Tenggara Barat',
  'Nusa Tenggara Timur',
  'Kalimantan Barat',
  'Kalimantan Tengah',
  'Kalimantan Selatan',
  'Kalimantan Timur',
  'Kalimantan Utara',
  'Sulawesi Utara',
  'Sulawesi Tengah',
  'Sulawesi Selatan',
  'Sulawesi Tenggara',
  'Gorontalo',
  'Sulawesi Barat',
  'Maluku',
  'Maluku Utara',
  'Papua Barat',
  'Papua',
];