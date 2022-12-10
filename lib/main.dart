import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mercatura/artikel/pages/article_list.dart';
import 'package:mercatura/artikel/pages/detail_article.dart';
import 'artikel/widget/drawer.dart';
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
          primarySwatch: Colors.red,
        ),
        home: const HomePage(),
        routes: {
          "/home": (BuildContext context) => const HomePage(),
          "/login": (BuildContext context) => const LoginPage(),
          "/register": (BuildContext context) => const RegisterPage(),
        },
      ),
    );
  }
}

