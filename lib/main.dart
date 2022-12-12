import 'package:flutter/material.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mercatura/pages/login_page.dart';
import 'package:mercatura/pages/register_page.dart';
import 'package:mercatura/pages/home_page.dart';
import 'package:mercatura/faq/pages/forms.dart';
import 'package:mercatura/faq/pages/output.dart';

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
          "/faq": (BuildContext context) => const FaqFormPage(),
          "/faq-output": (BuildContext context) => const FaqOutputPage(),
        },
      ),
    );
  }
}

