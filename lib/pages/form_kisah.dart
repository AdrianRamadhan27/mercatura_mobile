import 'package:mercatura/custom_widgets/drawer_widget.dart';
import 'package:mercatura/models/kisah.dart';
import 'package:mercatura/main.dart';
import 'package:mercatura/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:mercatura/config/api_config.dart';
List<Fields> listModel = [];

class FaqFormPage extends StatefulWidget {
  const FaqFormPage({super.key});

  @override
  State<FaqFormPage> createState() => _FaqFormPageState();
}

class _FaqFormPageState extends State<FaqFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _description = "Question";
  List<String> descriptionstatus = ["Question", "Answer"];

  Future<void> _onSubmitBtnPressed(CookieRequest request,
      ScaffoldMessengerState scaffoldMessenger) async {
    // 'username' and 'password' should be the values of the user login form.
    String username = request.cookies["user"]!;
    final Map<String, dynamic> response = await request.post("$apiUrl/faq/create_faq_json/", {
      'username': username,
      'title': _title,
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
            child: Container(
              child: ListView(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, right: 50, left: 50),
                shrinkWrap: true,
                children: <Widget>[
                  Center(
                      child: const Text(
                          'Berhasil disimpan')),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Kembali'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 120.0,
                            vertical: 25.0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10.0)),
                        primary: Colors.blue),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                ],
              ),
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
        title: const Text('Create'),
      ),
      drawer: DrawerWidget(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                // Input Judul
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Masukkan teks",
                    labelText: "Masukkan teks",
                    // Menambahkan circular border agar lebih rapi
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      _title = value!;
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

              DropdownButton(
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
              ),
              SizedBox(
                height: 85,
              ),
              Row(
                children: [
                  ElevatedButton(
                    child: Text('Simpan Data'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 135.0, vertical: 25.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        primary: Colors.purpleAccent),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _onSubmitBtnPressed(request, scaffoldMessenger);
                      }
                    },
                  ),
                  ElevatedButton(
                    child: Text('Daftar FAQ'),
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: 120.0,
                            vertical: 25.0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(10.0)),
                        primary: Colors.blue),
                    onPressed: () {
                      Navigator.pushNamed(context, "/faq-output");
                    },
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}