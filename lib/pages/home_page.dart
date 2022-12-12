import 'package:google_fonts/google_fonts.dart';
import 'package:mercatura/custom_widgets/drawer_widget.dart';
import 'package:mercatura/models/kisah.dart';
import 'package:flutter/material.dart';
import 'package:mercatura/utils/fetch.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Kisah>> futureKisahList;


  @override
  void initState() {
    super.initState();
    final request = Provider.of<CookieRequest>(context, listen: false);
    futureKisahList = fetchKisah(request);

  }

  void refresh() {
    final request = Provider.of<CookieRequest>(context, listen: false);
    setState(() {

      futureKisahList = fetchKisah(request);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mercatura', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      drawer: const DrawerWidget(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromARGB(255, 197, 226, 255),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: futureKisahList,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        "",
                        style: GoogleFonts.poppins(color: const Color(0xff59A5D8), fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                } else {

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                          ]),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Text(snapshot.data[index].fields.nama,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30.0)),
                              ),
                              subtitle: Padding(
                                  padding: const EdgeInsets.all(7.0),
                                  child: Text("Bidang: ${snapshot.data[index].fields.bidang}\nDeskripsi: ${snapshot.data[index].fields.deskripsi}\nBidang: ${snapshot.data[index].fields.usia}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 25.0),
                                  ),
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }
}