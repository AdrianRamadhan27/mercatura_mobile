import 'dart:convert';

// List<Article> articleFromJson(String str) => List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

List<Article> articleFromJson(String str) {
  List<Article> list = List<Article>.from(json.decode(str).map((x) => Article.fromJson(x)));

  list.sort(((a, b) => b.date.compareTo(a.date)));
  return list;
}

String articleToJson(List<Article> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Article {
    Article({
        required this.author,
        required this.title,
        required this.description,
        required this.date,
        required this.imageUrl,
    });

    List<String> author;
    String title;
    String description;
    DateTime date;
    String imageUrl;

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        author: List<String>.from(json["fields"]["author"].map((x) => x)),
        title: json["fields"]["title"],
        description: json["fields"]["description"],
        date: DateTime.parse(json["fields"]["date"]),
        imageUrl: json["fields"]["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "author": List<dynamic>.from(author.map((x) => x)),
        "title": title,
        "description": description,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "image_url": imageUrl,
    };
}
