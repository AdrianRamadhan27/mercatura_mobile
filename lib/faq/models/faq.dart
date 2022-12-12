// To parse this JSON data, do
//
//     final faq = faqFromJson(jsonString);

import 'dart:convert';

class Faq {
  Faq({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
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
    required this.user,
    required this.title,
    required this.description,
  });

  String user;
  String title;
  String description;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    title: json["title"],
    description: json["description"],

  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "title": title,
    "description": description,
  };
}
