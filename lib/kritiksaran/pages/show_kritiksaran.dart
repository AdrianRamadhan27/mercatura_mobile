// import 'dart: developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../widget/all_kritiksaran.dart';
import '../models/kritiksaran.dart';
import '../utils/fetch_kritiksaran.dart';
import '../../core/environments/endpoints.dart';
// import 'dart:developer';

class ShowKritikSaranPage extends StatefulWidget {
  const ShowKritikSaranPage({Key? key}) : super(key: key);

  @override
  State<ShowKritikSaranPage> createState() => _ShowKritikSaranPageState();
}

class _ShowKritikSaranPageState extends State<ShowKritikSaranPage> {
  final Future<List<KritikSaran>> future = fetchKritikSaran();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      // drawer: buildDrawer(context),
      body: FutureBuilder<List<KritikSaran>>(
          future: future,
          builder: (context, AsyncSnapshot<List<KritikSaran>> snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: [
                    Text(
                      "Tidak ada kritik/saran",
                      // style: GoogleFonts.poppins(
                      //     textStyle: const TextStyle(
                      //     color: Color(0xff59A5D8),
                      //     fontSize: 20)
                      // ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              } else {
                return Flexible(
                    child: ListView(
                        // padding: EdgeInsets.symmetric(
                        // horizontal: 20.0, vertical: 15.0),
                        padding: EdgeInsets.zero,
                        children: [
                      allKritikSaran(listKritikSaran: snapshot.data!),
                    ]));
              }
            }
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Tambah Kritik/Saran",
        backgroundColor: const Color.fromRGBO(94, 35, 157, 1),
        foregroundColor: Colors.white,
        elevation: 10.0,
        child: Text(
          "+",
          style: GoogleFonts.poppins(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        onPressed: () {
          if (request.loggedIn == false) {
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            Navigator.pushReplacementNamed(context, '/buatKritikSaran');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
