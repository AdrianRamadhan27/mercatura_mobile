// To parse this JSON data, do
//
//     final kritikSaran = kritikSaranFromJson(jsonString);

import 'dart:convert';

List<KritikSaran> kritikSaranFromJson(String str) => List<KritikSaran>.from(json.decode(str).map((x) => KritikSaran.fromJson(x)));

String kritikSaranToJson(List<KritikSaran> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KritikSaran {
    KritikSaran({
        required this.user,
        required this.title,
        required this.description,
        required this.username,
        required this.setuju,
    });

    List<String> user;
    String title;
    String description;
    String username;
    List<dynamic> setuju;

    factory KritikSaran.fromJson(Map<String, dynamic> json) => KritikSaran(
        user: List<String>.from(json["user"].map((x) => x)),
        title: json["title"],
        description: json["description"],
        username: json["username"],
        setuju: List<dynamic>.from(json["setuju"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x)),
        "title": title,
        "description": description,
        "username": username,
        "setuju": List<dynamic>.from(setuju.map((x) => x)),
    };
}