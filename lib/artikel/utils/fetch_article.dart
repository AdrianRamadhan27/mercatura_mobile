import 'package:http/http.dart' as http;
import '../models/article.dart';
import 'dart:convert';

Future<List<Article>> fetchArticle() async {
  var url = Uri.parse('https://mercatura-id.up.railway.app/artikel/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object MyWatchlist
  List<Article> listArticle = [];
  for (var d in data) {
    if (d != null) {
      listArticle.add(Article.fromJson(d));
    }
  }
  listArticle.sort(((a, b) => b.date.compareTo(a.date)));

  return listArticle;
}
