import 'package:google_fonts/google_fonts.dart';
import 'package:mercatura/custom_widgets/drawer_widget.dart';
import 'package:mercatura/models/kisah.dart';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mercatura/config/api_config.dart';
List<Fields> listModel = [];

class KisahFormPage extends StatefulWidget {
  const KisahFormPage({super.key});

  @override
  State<KisahFormPage> createState() => _KisahFormPageState();
}

class _KisahFormPageState extends State<KisahFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _age = "";
  String _workfield = "";
  String _description = "";

  Future<void> _onSubmitBtnPressed(CookieRequest request,
      ScaffoldMessengerState scaffoldMessenger) async {
    // 'username' and 'password' should be the values of the user login form.
    final Map<String, dynamic> response = await request.post("$apiUrl/create_kisah_json/", {
      'name': _name,
      'age': _age,
      'workfield': _workfield,
      'description': _description,
    });
    request.headers["X-CSRFToken"] = request.cookies["csrftoken"] ?? "";
    request.headers["Referer"] = apiUrl;
    if (!mounted) return;
    if (response["status"]) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor:
            Colors.white70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 15,
            child: ListView(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 20, right: 50, left: 50),
              shrinkWrap: true,
              children: <Widget>[
                const Center(
                    child: Text(
                        'Berhasil disimpan')),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 120.0,
                          vertical: 25.0),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10.0))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Kembali'),
                ),

              ],
            ),
          );
        },
      );
    } else {
      final snackBar = SnackBar(content: Text(response["message"]));
      scaffoldMessenger.showSnackBar(snackBar);
    }

  }


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kisah UMKM', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      drawer: const DrawerWidget(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                // Input nama
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama",
                    labelText: "Masukkan nama",
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                // Input usia
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Masukkan usia",
                    labelText: "Masukkan usia",
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      _age = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      _age = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tidak boleh kosong!';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                // Input Bidang 
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Bidang",
                    labelText: "Masukkan bidang",
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      _workfield = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      _workfield = value!;
                    });
                  },
                  // Validator sebagai validasi form
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Tidak boleh kosong!';
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
                              _description = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _description = value!;
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

              /*DropdownButton(
                value: _description,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: descriptionstatus.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _description = newValue!;
                  });
                },
              ),*/
              const SizedBox(
                height: 85,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 135.0, vertical: 25.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _onSubmitBtnPressed(request, scaffoldMessenger);
                  }
                },
                child: const Text('Simpan Data'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}