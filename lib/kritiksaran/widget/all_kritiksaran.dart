import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import '../models/kritiksaran.dart';
// import 'package:google_fonts/google_fonts.dart';

class allKritikSaran extends StatelessWidget {
    const allKritikSaran({
        Key? key,
        required this.listKritikSaran
    }) : super(key: key);

    final List<KritikSaran> listKritikSaran;


@override
Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text(
                            "Semua Kritik dan Saran",
                            // style: GoogleFonts.poppins(
                            //     color: const Color.fromARGB(255, 49, 19, 82),
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 20.0,
                            // ),
                        ),
                    ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: 200,
                    // scrollDirection: Axis.horizontal,
                    child: ListView.builder(
                    itemCount: listKritikSaran.length,
                    itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    const SizedBox(height: 10),
                                    Text(
                                        listKritikSaran[index].title, 
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
                                        listKritikSaran[index].description, 
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
                                        
                                        listKritikSaran[index].username, 
                                        overflow: TextOverflow.ellipsis,
                                        // style: GoogleFonts.poppins(
                                        //     color: Colors.black,
                                        //     fontWeight: FontWeight.w600,
                                        //     fontSize: 14.0,
                                        //     height: 1.5
                                        // ),
                                    ),
                                ],
                        
                            ));

                        // );
                    }
                ),
                )
            ],
        ));
    
}
}