import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../custom_widgets/drawer_widget.dart';
import '../models/kritiksaran_anon.dart';
class ShowKritikSaranAnon extends StatefulWidget{
    const ShowKritikSaranAnon({super.key});

    @override
    State<ShowKritikSaranAnon> createState() => _ShowKritikSaranAnonState();
}

class _ShowKritikSaranAnonState extends State<ShowKritikSaranAnon> {
    @override
  Widget build(BuildContext context) {
        return Scaffold(
            drawer: const DrawerWidget(),
            appBar: AppBar(
                title: Text(
                    'Kritik & Saran',
                    style: GoogleFonts.poppins(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                    ),
                ),
            ),

            body: ListView.builder(
                itemBuilder: (context, index) {
                    return Card(
                        child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.blue,
                              ),
                            child:

                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                            KritikSaranAnon.kritikSaranAnonList[index].judul,
                                            style: GoogleFonts.poppins(
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                            ),
                                        ),
                                    ),

                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child:
                                            Text(
                                                KritikSaranAnon.kritikSaranAnonList[index].deskripsi,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 24.0,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),



                                    ),
                                ],
                            ),
                        ),
                    );
                },

                itemCount: KritikSaranAnon.kritikSaranAnonList.length,

            ),
        );
    }
}
