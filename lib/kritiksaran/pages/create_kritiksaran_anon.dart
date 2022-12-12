import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../custom_widgets/drawer_widget.dart';
import '../models/kritiksaran_anon.dart';

class KritikSaranForm extends StatefulWidget {
  const KritikSaranForm({super.key});

    @override
    State<KritikSaranForm> createState() =>  _KritikSaranFormState();
}

class _KritikSaranFormState extends State<KritikSaranForm> {
    final _formKey = GlobalKey<FormState>();
    String _judul = "";
    String _deskripsi = "";
    final TextEditingController _controllerJudul = TextEditingController();
    final TextEditingController _controllerDeskripsi = TextEditingController();
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            drawer: const DrawerWidget(),
            appBar: AppBar(
                title: Text(
                    'Tulis Kritik/Saran',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                    ),
                ),
            ),

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
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                            ),
                            controller: _controllerJudul,
                            decoration: InputDecoration(
                                hintText: "Judul Kritik atau Saran",
                                labelText: "Judul",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
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
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                            ),
                            controller: _controllerDeskripsi,
                            maxLines: 5,
                            decoration: InputDecoration(
                                hintText: "Deskripsi Kritik atau Saran",
                                labelText: "Deskripsi",
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
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
                            child: Text (
                                "Simpan",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                ),
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