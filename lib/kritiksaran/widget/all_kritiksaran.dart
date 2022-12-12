import 'package:flutter/material.dart';
import '../models/kritiksaran.dart';
import 'package:google_fonts/google_fonts.dart';

class AllKritikSaran extends StatelessWidget {
  const AllKritikSaran({Key? key, required this.listKritikSaran})
      : super(key: key);

  final List<KritikSaran> listKritikSaran;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Semua Kritik dan Saran",

                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                  ),
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
                                "Judul: ${listKritikSaran[index].title}" ,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    height: 1.5
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Deskripsi: ${listKritikSaran[index].description}",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    height: 1.5
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "User: ${listKritikSaran[index].username}",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    height: 1.5
                                ),
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
