import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mercatura/config/api_config.dart';
import 'package:mercatura/custom_widgets/drawer_widget.dart';
import 'package:mercatura/umkm/models/umkm.dart';






class UmkmFormPage extends StatefulWidget {
  const UmkmFormPage({super.key});

  @override
  State<UmkmFormPage> createState() => _UmkmFormPageState();
}

class _UmkmFormPageState extends State<UmkmFormPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;



  Future<void> _onSubmitBtnPressed(CookieRequest request,
      ScaffoldMessengerState scaffoldMessenger) async {
    setState(() {
      isLoading = true;
    });
    // 'username' and 'password' should be the values of the user login form.
    final Map<String, dynamic> response = await request.post("$apiUrl/umkm/add_umkm_json/", {
      'nama_usaha': _namaUsaha,
      'lokasi_usaha': _lokasiUsaha,
      'deskripsi_usaha': _deskripsiUsaha,
      'bidang_usaha': _bidangUsaha,
      'website_usaha': _websiteUsaha,
      'logo_usaha': _logoUsaha,
      'email_usaha': _emaiUsaha,
      'pemilik_usaha': request.cookies["user"],
    });
    request.headers["X-CSRFToken"] = request.cookies["csrftoken"] ?? "";
    request.headers["Referer"] = apiUrl;
    if (!mounted) return;
    if (response["status"]) {
      final snackBar = SnackBar(content: Text("Berhasil menambahkan $_namaUsaha"));
      scaffoldMessenger.showSnackBar(snackBar);
      Navigator.of(context).pushReplacementNamed("/umkm");
    } else {
      final snackBar = SnackBar(content: Text(response["message"]));
      scaffoldMessenger.showSnackBar(snackBar);
    }
    setState(() {
      isLoading = false;
    });
  }

  String _namaUsaha = "Test";
  String _lokasiUsaha = "Aceh";
  String _bidangUsaha = "Agribisnis";
  String _emaiUsaha= "test@gmail.com";
  String _deskripsiUsaha = "Fasdffdas";
  String _websiteUsaha = "http://127.0.0.1:8000";
  String _logoUsaha = "https://cdn.techinasia.com/data/images/1c081e81df808dff8f0e830603788a66.jpg";



  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // The rest of your widgets are down below
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Tambah UMKM", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Form UMKM ${request.cookies["user"]!}",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: GoogleFonts.poppins(),
                          decoration: const InputDecoration(
                            labelText: "Nama Usaha",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _namaUsaha = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _namaUsaha = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama usaha tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.class_),
                        title: Text(
                          'Pilih Bidang Usaha',
                          style: GoogleFonts.poppins()
                        ),
                        trailing: DropdownButton(
                          value: _bidangUsaha,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: daftarBidang.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items, style: GoogleFonts.poppins()),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {

                              _bidangUsaha = newValue!;

                            });
                          },
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_pin),
                        title: Text(
                          'Pilih Lokasi Usaha',
                          style: GoogleFonts.poppins()
                        ),
                        trailing: DropdownButton(
                          value: _lokasiUsaha,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: daftarProvinsi.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items, style: GoogleFonts.poppins()),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _lokasiUsaha = newValue!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: GoogleFonts.poppins(),
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email Usaha",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _emaiUsaha = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _emaiUsaha = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong!';
                            }
                            return null;
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: GoogleFonts.poppins(),
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                            labelText: "Website Usaha",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _websiteUsaha = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _websiteUsaha = value!;
                            });
                          },

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: GoogleFonts.poppins(),
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                            labelText: "Logo Usaha",
                            border: OutlineInputBorder(),
                            hintText: "Masukkan url logo"
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _logoUsaha = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _logoUsaha = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon pilih logo usaha!';
                            }
                            return null;
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: GoogleFonts.poppins(),
                          minLines: 2,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                              labelText: "Deskripsi Usaha",
                              border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _deskripsiUsaha = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _deskripsiUsaha = value!;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                Navigator.pop(context);
                              },
                              child: Text("Kembali", style: GoogleFonts.poppins())),
                          const SizedBox(
                            width: 20.0,
                          ),
                          ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                if (_formKey.currentState!.validate()) {
                                  _onSubmitBtnPressed(request, scaffoldMessenger);
                                }
                              },
                              child: Text("Simpan", style: GoogleFonts.poppins())),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}