
import 'package:flutter/material.dart';
import 'package:mercatura/main.dart';
import 'package:mercatura/pages/login_page.dart';
import 'package:mercatura/api/pengguna_api.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String? route = ModalRoute.of(context)?.settings.name;

    // TODO: implement build
    return Drawer(
      child: Column(
        children: [
          // Menambahkan clickable menu
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.of(context).pushReplacementNamed("/home");
            },
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.of(context).pushReplacementNamed("/login");
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              // Route menu ke halaman utama
              logout(request);
              const snackBar = SnackBar(content: Text("Berhasil logout!"));
              scaffoldMessenger.showSnackBar(snackBar);
              Navigator.of(context).pushReplacementNamed("/login");

            },
          ),
          ListTile(
            title: const Text('Kumpulan Artikel'),
            onTap: () {
              // ke homepage
              if (route == '/artikel') {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/artikel');
              }
            },
          ),

          ListTile(
            title: const Text('List Artikel'),
            onTap: () {
              // ke homepage
              if (route == '/artikel/discover') {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/artikel/discover');
              }
            },
          ),

          ListTile(
            title: const Text('Tambah Artikel'),
            onTap: () {
              if (route == '/artikel/create') {
                Navigator.pop(context);
              } else {
                Navigator.pushReplacementNamed(context, '/artikel/create');
              }
            },
          ),
        ],
      ),
    );
  }
}