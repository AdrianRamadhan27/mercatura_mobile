import 'dart:convert' as convert;
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mercatura/artikel/pages/discover_article.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../core/environments/endpoints.dart';
import '../models/article.dart';
import '../widget/drawer.dart';

class CreateArticle extends StatefulWidget {
  const CreateArticle({Key? key}) : super(key: key);

  @override
  State<CreateArticle> createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? _title = '';
  String? _imageUrl = '';
  String? _description = '';

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(94, 35, 157, 1),
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/artikel/discover');
          },
        ),
        title: Text(
          "Tambah Artikel",
          style: GoogleFonts.poppins(
            color: const Color.fromRGBO(94, 35, 157, 1),
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Artikel milikmu nantinya akan ditampilkan pada halaman Kumpulan Artikel.",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: GoogleFonts.poppins(),
                  decoration: const InputDecoration(
                    labelText: "Judul",
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _title = value;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _title = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Tautan Gambar",
                  ),
                  onChanged: (String value) {
                    setState(() {
                      _imageUrl = value;
                    });
                  },
                  onSaved: (String? value) {
                    setState(() {
                      _imageUrl = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tautan Gambar tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: TextFormField(
                    minLines: null,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      labelText: "Deskripsi",
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _description = value;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        _description = value;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      final response = await request.post(
                        Endpoint.createPostJson, 
                        convert.jsonEncode(
                          {
                            'title': _title,
                            'description': _description,
                            'image_url': _imageUrl,
                            'date': DateTime.now().toString()
                          }
                        )
                      );
                      log(response.toString());
                      if (response['status']) {
                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DiscoverPage(),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Isi semua dengan benar!',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.red,
                      ));
                    }
                  }, 
                  child: Text(
                    "Tambah Artikel",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
