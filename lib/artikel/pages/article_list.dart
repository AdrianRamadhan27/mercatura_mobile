import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/newest_article.dart';
import '../widget/list_article.dart';
import '../models/article.dart';
import '../widget/drawer.dart';
import '../utils/fetch_article.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  final Future<List<Article>> future = fetchArticle();

  @override
  Widget build(BuildContext context) {
    future.then((value){
      log(articleToJson(value));
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      drawer: buildDrawer(context),
      body: FutureBuilder<List<Article>>(
        future: future,
        builder: (context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Column(
                children: [
                  Text(
                    "Oh no! Tidak ada artikel :(",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                      color: Color(0xff59A5D8), 
                      fontSize: 20)
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              );
            } else {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  ArtikelTerbaru(articles: snapshot.data!),
                  kumpulanArtikel(articles: snapshot.data!)
                ],
              );
            }
          }
        }
      )
    );
  }
}


