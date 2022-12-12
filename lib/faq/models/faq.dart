// To parse this JSON data, do
//
//     final faq = faqFromJson(jsonString);

import 'dart:convert';

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
