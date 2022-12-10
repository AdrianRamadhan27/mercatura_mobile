import 'package:flutter/material.dart';
import 'package:mercatura/config/api_config.dart';
import 'package:mercatura/custom_widgets/mydrawer.dart';
import 'package:mercatura/umkm/models/umkm.dart';
import 'package:mercatura/umkm/api/umkm_api.dart';


import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

List<String> daftar_filter_bidang = [...daftar_bidang, "Semua"];
List<String> daftar_filter_provinsi = [...daftar_provinsi, "Semua"];

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
    futureUmkmLIst = fetchUmkmList(request, _search_query, _bidang_usaha, _lokasi_usaha);

  }

  void refresh() {
    final request = Provider.of<CookieRequest>(context, listen: false);
    setState(() {

      futureUmkmLIst = fetchUmkmList(request, _search_query, _bidang_usaha, _lokasi_usaha);
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

  String _search_query = "";
  String _bidang_usaha = "Semua";
  String _lokasi_usaha = "Semua";
  List<Color> daftar_warna = [];


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();


    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // The rest of your widgets are down below
    return Scaffold(
      appBar: AppBar(
        title: const Text("UMKM"),
      ),
      drawer: const MyDrawer(),
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
                        const Text("Cari UMKM"),
                        request.loggedIn ?
                        TextButton(
                          child: Text("Tambah UMKM"),
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
                        decoration: const InputDecoration(
                          labelText: "Kata Kunci",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _search_query = value!;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            _search_query = value!;
                          });
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
                        items: daftar_filter_bidang.map((String items) {
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
                        'Pilih Lokasi',
                      ),
                      trailing: DropdownButton(
                        value: _lokasi_usaha,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: daftar_filter_provinsi.map((String items) {
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
                    ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                          if (_formKey.currentState!.validate()) {
                            _onSubmitBtnPressed(request, scaffoldMessenger);
                          }
                        },
                        child: const Text("Cari")),
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
          Container(
              child: FutureBuilder(
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
                          children: const [
                            Text(
                              "UMKM Tidak Ditemukan",
                            ),
                            SizedBox(height: 8),
                          ],
                        );
                      } else {

                        daftar_warna = [];
                        for (Umkm data in snapshot.data) {
                          daftar_warna.add(Colors.blue);
                        }

                        return Expanded(
                          child: SingleChildScrollView(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index)=> MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  onEnter: (event) {
                                    setState(() {
                                      daftar_warna[index] = Colors.red;
                                    });
                                  },
                                  onExit: (event) {
                                    setState(() {
                                      daftar_warna[index] = Colors.blue;
                                    });
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/detail_umkm', arguments:snapshot.data![index].pk);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                      padding: const EdgeInsets.all(20.0),
                                      decoration: BoxDecoration(
                                          color:Colors.white,
                                          border: Border.all(
                                              color: daftar_warna[index],
                                              width: 3.0
                                          ),
                                          borderRadius: BorderRadius.circular(15.0),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.black,
                                                blurRadius: 2.0
                                            )
                                          ]
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              child: Image.network(snapshot.data![index].fields.logoUsaha,
                                                  height:40)
                                          ),
                                          Text(
                                            "${snapshot.data![index].fields.namaUsaha}",
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ),
                        );
                      }
                    }
                  }
              )
          )
        ],
      ),
    );
  }
}