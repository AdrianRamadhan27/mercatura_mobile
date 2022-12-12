// To parse this JSON data, do
//
//     final kisah = kisahFromJson(jsonString);

import 'dart:convert';

List<Kisah> kisahFromJson(String str) => List<Kisah>.from(json.decode(str).map((x) => Kisah.fromJson(x)));

String kisahToJson(List<Kisah> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kisah {
  Kisah({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Kisah.fromJson(Map<String, dynamic> json) => Kisah(
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
    required this.nama,
    required this.bidang,
    required this.deskripsi,
    required this.usia,
  });

  String nama;
  String bidang;
  String deskripsi;
  String usia;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    nama: json["name"],
    bidang: json["workfield"],
    deskripsi: json["description"],
    usia: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "name": nama,
    "workfield": bidang,
    "description": deskripsi,
    "age": usia,
  };
}