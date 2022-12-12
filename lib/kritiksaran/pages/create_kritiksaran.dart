import 'dart:convert' as convert;
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../../core/environments/endpoints.dart';
import '../models/kritiksaran.dart';
import '../pages/show_kritiksaran.dart';


class CreateKritikSaran extends StatefulWidget {
    const CreateKritikSaran({Key? key}): super(key: key);

    State<CreateKritikSaran> createState() => _CreateKritikSaranState();
}

class _CreateKritikSaranState extends State<CreateKritikSaran> {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String? title = "";
    String? description = "";
    TextEditingController _controllerTitle = TextEditingController();
    TextEditingController _controllerDescription = TextEditingController();


    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();

        return Scaffold(
            appBar: AppBar(
                title: const Text(
                    'Tulis Kritik/Saran',
                    // style: GoogleFonts.poppins(
                    //     color: Colors.black,
                    //     fontSize: 24.0,
                    //     fontWeight: FontWeight.bold,
                    // ),
                ),
                centerTitle: true,
                
            ),

            body: SafeArea(
                child: Form(
                    key: _formKey,
                    child: Column(
                        children: [
                            const SizedBox(height :10),
                            TextFormField(
                                controller: _controllerTitle,
                                decoration: const InputDecoration(
                                    labelText: "Judul",
                                    hintText: "Judul Kritik atau Saran",
                                    // border: const OutlineInputBorder(
                                    //     borderRadius: const BorderRadius.circular(20.0),
                                    // ),
                                ),

                                onChanged: (String? value) {
                                    setState(() {
                                        title = value;
                                    });
                                },

                                onSaved: (String? value) {
                                    setState(() {
                                        title = value;
                                    });
                                },

                                validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                        return 'Judul tidak boleh kosong!';
                                    }
                                    return null;
                                },

                            ),

                            const SizedBox(height :10),
                            TextFormField(
                                controller: _controllerDescription,
                                decoration: const InputDecoration(
                                    labelText: "Deskripsi",
                                    hintText: "Deskripsi Kritik atau Saran",
                                    // border: const OutlineInputBorder(
                                    //     borderRadius: const BorderRadius.circular(20.0),
                                    // ),
                                ),

                                onChanged: (String? value) {
                                    setState(() {
                                        description = value;
                                    });
                                },

                                onSaved: (String? value) {
                                    setState(() {
                                        description = value;
                                    });
                                },

                                validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                        return 'Deskripsi tidak boleh kosong!';
                                    }
                                    return null;
                                },

                            ),
                            

                            const SizedBox(height: 24),
        
                            ElevatedButton(
                            onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                final response = await request.post(
                                    Endpoint.createKritikSaranJson, 
                                    convert.jsonEncode(
                                    {
                                        'title': title,
                                        'description': description,
                                        
                                    }
                                    )
                                );
                                //   log(response.toString());
                                if (response['status']) {
                                    if (!mounted) return;
                                    _controllerDescription.clear();
                                    _controllerTitle.clear();

                                    // Navigator.pushReplacement(
                                    // context,
                                    
                                    // MaterialPageRoute(
                                    //     builder: (context) => const ShowKritikSaranPage(),
                                    // ),
                                    // );
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
                                "Tambah Kritik/Saran",
                                // style: GoogleFonts.poppins(
                                //   textStyle: const TextStyle(
                                //     color: Colors.white,
                                //     fontSize: 16,
                                //     fontWeight: FontWeight.bold
                                //   )
                                // ),
                            )
                )

                        ],
                    ),
                ),
            ),
        );
    }
}