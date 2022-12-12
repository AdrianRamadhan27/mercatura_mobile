import 'package:flutter/material.dart';
import '../pages/article_list.dart';
import '../../main.dart';

Drawer buildDrawer(BuildContext context) {
  String? route = ModalRoute.of(context)?.settings.name;

  return Drawer(
    child: Column(
      children: [
        // Menambahkan clickable menu
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
              // ke form budget
              Navigator.pushReplacementNamed(context, '/artikel/create');
            }
          },
        ),
      ],
    ),
  );
}
