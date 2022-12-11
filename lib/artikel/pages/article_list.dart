import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mercatura/custom_widgets/drawer_widget.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
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
    final request = context.watch<CookieRequest>();
    // future.then((value){
    //   log(articleToJson(value));
    // });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 210, 176, 247), size: 30),
      ),
      extendBodyBehindAppBar: true,
      drawer: const DrawerWidget(),
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
                              color: Color(0xff59A5D8), fontSize: 20)),
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
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Tambah artikel",
        backgroundColor: const Color.fromRGBO(94, 35, 157, 1),
        foregroundColor: Colors.white,
        elevation: 10.0,
        child: Text(
          "+",
          style: GoogleFonts.poppins(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        onPressed: () {
          if (request.loggedIn == false) {
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            Navigator.pushReplacementNamed(context, '/artikel/create');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
