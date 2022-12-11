import 'package:flutter/material.dart';
import 'package:mercatura/artikel/pages/article_list.dart';
import 'package:mercatura/artikel/pages/create_article.dart';
import 'package:mercatura/artikel/pages/detail_article.dart';
import 'artikel/pages/discover_article.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mercatura/pages/login_page.dart';
import 'package:mercatura/pages/register_page.dart';
import 'package:mercatura/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Flutter App',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(94, 35, 157, 1),
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: Color.fromRGBO(94, 35, 157, 1),
                width: 1.2
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromRGBO(94, 35, 157, 1),
                width: 1.2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromRGBO(94, 35, 157, 1),
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromRGBO(94, 35, 157, 1),
                width: 1.2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromRGBO(94, 35, 157, 1),
                width: 1.2,
              ),
            ),
          )
        ),
        home: const HomePage(),
        routes: {
          "/home": (BuildContext context) => const HomePage(),
          "/login": (BuildContext context) => const LoginPage(),
          "/register": (BuildContext context) => const RegisterPage(),
          "/artikel": (context) => const ArticlePage(),
          "/artikel/discover": (context) => const DiscoverPage(),
          "/artikel/create": (context) => const CreateArticle(),
          "/artikel/detail": (context) => const ArticleDetail()
        },
      ),
    );
  }
}


