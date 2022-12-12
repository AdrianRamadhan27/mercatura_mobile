import 'package:mercatura/custom_widgets/mydrawer.dart';
import 'package:mercatura/faq/models/faq.dart';
import 'package:mercatura/main.dart';
import 'package:mercatura/faq/pages/output.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


List<Fields> listModel = [];

class FaqFormPage extends StatefulWidget {
  const FaqFormPage({super.key});

  @override
  State<FaqFormPage> createState() => _FaqFormPageState();
}

class _FaqFormPageState extends State<FaqFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _user = "";
  String _title = "";
  String _description = "Question";
  List<String> descriptionstatus = ["Question", "Answer"];


  @override
  Widget build(BuildContext context) {
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
                    final faq = Fields(
                        user: _user,
                        title: _title,
                        description: _description);
                    listModel.add(faq);
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
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

