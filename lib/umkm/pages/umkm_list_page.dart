import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mercatura/custom_widgets/drawer_widget.dart';
import 'package:mercatura/umkm/models/umkm.dart';
import 'package:mercatura/umkm/api/umkm_api.dart';
import 'package:mercatura/umkm/widgets/umkm_cards.dart';




List<String> daftarFilterBidang = ["Semua", ...daftarBidang];
List<String> daftarFilterProvinsi = ["Semua", ...daftarProvinsi];

class UmkmListPage extends StatefulWidget {
  const UmkmListPage({super.key});


  @override
  State<UmkmListPage> createState() => _UmkmListPageState();
}

class _UmkmListPageState extends State<UmkmListPage> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isLoading = false;


  late Future<List<Umkm>> futureUmkmLIst;


  @override
  void initState() {
    super.initState();
    final request = Provider.of<CookieRequest>(context, listen: false);
    futureUmkmLIst = fetchUmkmList(request, _searchQuery, _bidangUsaha, _lokasiUsaha);

  }

  void refresh() {
    final request = Provider.of<CookieRequest>(context, listen: false);
    setState(() {

      futureUmkmLIst = fetchUmkmList(request, _searchQuery, _bidangUsaha, _lokasiUsaha);
    });
  }

  Future<void> _onSubmitBtnPressed(CookieRequest request,
      ScaffoldMessengerState scaffoldMessenger) async {
    setState(() {
      isLoading = true;
    });
    refresh();

    setState(() {

      isLoading = false;
    });
  }

  String _searchQuery = "";
  String _bidangUsaha = "Semua";
  String _lokasiUsaha = "Semua";



  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();


    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // The rest of your widgets are down below
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar UMKM",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Cari UMKM",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                        ),
                        (request.loggedIn && request.cookies["user"] != null) ?
                        TextButton(
                          child: Text(
                              "Tambah UMKM",
                              style: GoogleFonts.poppins(),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/tambah_umkm');
                          },
                        ) :
                        Container(),
                      ]
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: GoogleFonts.poppins(),
                        decoration: const InputDecoration(
                          labelText: "Kata Kunci",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _searchQuery = value!;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            _searchQuery = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.class_),
                      title: Text(
                        'Bidang',
                        style: GoogleFonts.poppins(),
                      ),
                      trailing: DropdownButton(
                        value: _bidangUsaha,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: daftarFilterBidang.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,
                              style: GoogleFonts.poppins()),
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
                      title:  Text(
                        'Lokasi',
                        style: GoogleFonts.poppins()
                      ),
                      trailing: DropdownButton(
                        value: _lokasiUsaha,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: daftarFilterProvinsi.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,
                                style: GoogleFonts.poppins()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _lokasiUsaha = newValue!;
                          });
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
                        child: Text("Cari",
                            style: GoogleFonts.poppins())),
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
          FutureBuilder(
              future: futureUmkmLIst,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {

                  if (snapshot.data.length == 0) {
                    return Column(
                      children:  [
                        Text(
                          "UMKM Tidak Ditemukan",
                          style: GoogleFonts.poppins()
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  } else {



                    return Expanded(
                      child: SingleChildScrollView(
                        child: UmkmCards(umkmList: snapshot.data, refreshFunction: refresh),
                      ),
                    );
                  }
                }
              }
          )
        ],
      ),
    );
  }
}