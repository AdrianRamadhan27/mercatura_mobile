
import 'package:flutter/material.dart';

import 'package:mercatura/api/pengguna_api.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
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
            title: const Text('UMKM'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.of(context).pushReplacementNamed("/umkm");
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

        ],
      ),
    );
  }
}