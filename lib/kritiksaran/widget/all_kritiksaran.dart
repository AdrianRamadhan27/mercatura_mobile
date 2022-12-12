import 'package:flutter/material.dart';
import 'package:mercatura/kritiksaran/utils/fetch_kritiksaran.dart';
// import 'package:intl/intl.dart';
import '../models/kritiksaran.dart';
// import 'package:google_fonts/google_fonts.dart';

class allKritikSaran extends StatelessWidget {
  const allKritikSaran({Key? key, required this.listKritikSaran})
      : super(key: key);

  final List<KritikSaran> listKritikSaran;

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Semua Kritik dan Saran'),
    //     ),
    //     body: FutureBuilder(
    //       future: fetchKritikSaran(),
    //       builder: (context, AsyncSnapshot snapshot) {
    //         if (snapshot.data == null) {
    //           return const Center(child: CircularProgressIndicator());
    //         } else {
    //           if (!snapshot.hasData) {
    //             return Column(
    //               children: const [
    //                 Text(
    //                   "Belum ada kritik/saran",
    //                 ),
    //                 SizedBox(height: 8),
    //               ],
    //             );
    //           } else {
    //             return ListView.builder(
    //                 itemCount: snapshot.data!.length,
    //                 itemBuilder: (_, index) => ListTile(
    //                   title: ""

    //                 ));
    //           }
    //         }
    //       },
    //     ));
    return Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Semua Kritik dan Saran",

                  // style: (
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 20.0,
                  // ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 1000.0,
              // scrollDirection: Axis.horizontal,
              child: ListView.builder(
                  itemCount: listKritikSaran.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: const Color.fromRGBO(94, 35, 157, 1),
                      child: Container(
                          padding: const EdgeInsets.all(9.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                "Judul: " + listKritikSaran[index].title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white),
                                // style: GoogleFonts.poppins(
                                //     color: Colors.black,
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 14.0,
                                //     height: 1.5
                                // ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Deskripsi: " +
                                    listKritikSaran[index].description,
                                style: TextStyle(color: Colors.white),

                                overflow: TextOverflow.ellipsis,
                                // style: GoogleFonts.poppins(
                                //     color: Colors.black,
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 14.0,
                                //     height: 1.5
                                // ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "User: " + listKritikSaran[index].username,
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                // style: GoogleFonts.poppins(
                                //     color: Colors.black,
                                //     fontWeight: FontWeight.w600,
                                //     fontSize: 14.0,
                                //     height: 1.5
                                // ),
                              ),
                            ],
                          )),

                      // );
                    );
                  }),
            )
          ],
        ));
  }
}
