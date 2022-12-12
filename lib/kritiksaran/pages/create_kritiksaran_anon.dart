import 'package:flutter/material.dart';
import 'show_kritiksaran_anon.dart';
import '../models/kritiksaran_anon.dart';

class KritikSaranForm extends StatefulWidget {
    @override
    _KritikSaranFormState createState() => new _KritikSaranFormState();
}

class _KritikSaranFormState extends State<KritikSaranForm> {
    final _formKey = GlobalKey<FormState>();
    String _judul = "";
    String _deskripsi = "";
    TextEditingController _controllerJudul = TextEditingController();
    TextEditingController _controllerDeskripsi = TextEditingController();
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Form'),
            ),

            // drawer: appDrawer(context),

            body: Form(
            key: _formKey,
            child: SingleChildScrollView (
                child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    children:[
                        Padding (
                         padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _controllerJudul,
                            decoration: new InputDecoration(
                                hintText: "Judul Kritik atau Saran",
                                labelText: "Judul",
                                border: new OutlineInputBorder(
                                    borderRadius: new BorderRadius.circular(20.0),
                                ),
                            ), // InputDecoration

                            onChanged: (String? value) {
                                setState(() {
                                    _judul = value!;
                                });
                            },

                            onSaved: (String? value) {
                                setState(() {
                                    _judul = value!;
                                });
                            },

                            validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                    return 'Judul tidak boleh kosong!';
                                }
                                return null;
                            },

                        
                        ), //TextField
                    ),

                        Padding(
                        padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                            controller: _controllerDeskripsi,
                            maxLines: 5,
                            decoration: new InputDecoration(
                                hintText: "Deskripsi Kritik atau Saran",
                                labelText: "Deskripsi",
                                border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                                ),
                            ), // InputDecoration


                            onChanged: (String? value) {
                                 setState(() {
                                    _deskripsi = value!;
                                 });
                            },

                            onSaved: (String? value) {
                                 setState(() {
                                    _deskripsi = value!;
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

                        TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.blue),
                            ),

                            onPressed: () {

                                if (_formKey.currentState!.validate()){
                                    KritikSaranAnon.tambahKritikSaran(judul: _judul, deskripsi: _deskripsi);
                                    _controllerJudul.clear();
                                    _controllerDeskripsi.clear();
                                }

                            },
                            child: const Text (
                                "Simpan",
                                style: TextStyle(color: Colors.white),
                            ),
                        ),

                    ], // <Widget>[]
                ), // Column
                ),
                ),
            ),
        );
    }
}