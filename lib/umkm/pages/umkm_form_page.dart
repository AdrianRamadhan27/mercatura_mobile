import 'package:flutter/material.dart';
import 'package:mercatura/config/api_config.dart';
import 'package:mercatura/custom_widgets/mydrawer.dart';
import 'package:mercatura/umkm/models/umkm.dart';


import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';



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
      'nama_usaha': _nama_usaha,
      'lokasi_usaha': _lokasi_usaha,
      'deskripsi_usaha': _deskripsi_usaha,
      'bidang_usaha': _bidang_usaha,
      'website_usaha': _website_usaha,
      'logo_usaha': _logo_usaha,
      'email_usaha': _email_usaha,
      'pemilik_usaha': request.cookies["user"],
    });
    request.headers["X-CSRFToken"] = request.cookies["csrftoken"] ?? "";
    request.headers["Referer"] = apiUrl;
    if (!mounted) return;
    if (response["status"]) {
      final snackBar = SnackBar(content: Text(response["message"]));
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

  String _nama_usaha = "Test";
  String _lokasi_usaha = "Aceh";
  String _bidang_usaha = "Agribisnis";
  String _email_usaha= "test@gmail.com";
  String _deskripsi_usaha = "Fasdffdas";
  String _website_usaha = "http://127.0.0.1:8000";
  String _logo_usaha = "https://cdn.techinasia.com/data/images/1c081e81df808dff8f0e830603788a66.jpg";



  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // The rest of your widgets are down below
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah UMKM"),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text("Form UMKM " + request.cookies["user"]!),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Nama Usaha",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _nama_usaha = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _nama_usaha = value!;
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
                        title: const Text(
                          'Pilih Bidang Usaha',
                        ),
                        trailing: DropdownButton(
                          value: _bidang_usaha,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: daftar_bidang.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {

                              _bidang_usaha = newValue!;

                            });
                          },
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_pin),
                        title: const Text(
                          'Pilih Lokasi Usaha',
                        ),
                        trailing: DropdownButton(
                          value: _lokasi_usaha,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: daftar_provinsi.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _lokasi_usaha = newValue!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email Usaha",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _email_usaha = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _email_usaha = value!;
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
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                            labelText: "Website Usaha",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _website_usaha = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _website_usaha = value!;
                            });
                          },

                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(
                            labelText: "Logo Usaha",
                            border: OutlineInputBorder(),
                            hintText: "Masukkan url logo"
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _logo_usaha = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _logo_usaha = value!;
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
                          decoration: const InputDecoration(
                              labelText: "Deskripsi Usaha",
                              border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _deskripsi_usaha = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _deskripsi_usaha = value!;
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
                      ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              _onSubmitBtnPressed(request, scaffoldMessenger);
                            }
                          },
                          child: const Text("Submit")),
                      const SizedBox(
                        height: 30,
                      ),
                      if (isLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}