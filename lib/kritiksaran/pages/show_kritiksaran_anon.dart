import 'package:flutter/material.dart';
import 'show_kritiksaran_anon.dart';
import '../models/kritiksaran_anon.dart';
import 'create_kritiksaran_anon.dart';
class ShowKritikSaranAnon extends StatefulWidget{
    const ShowKritikSaranAnon({super.key});

    State<ShowKritikSaranAnon> createState() => _ShowKritikSaranAnonState();
}

class _ShowKritikSaranAnonState extends State<ShowKritikSaranAnon> {
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Kritik Saran Mobile'),
            ),

            // drawer: appDrawer(context),

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
                                            KritikSaranAnon.KritikSaranAnonList[index].judul,
                                            style: const TextStyle(fontSize: 15),
                                        ),
                                    ),

                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child:
                                            Text(
                                                KritikSaranAnon.KritikSaranAnonList[index].deskripsi,
                                                style: const TextStyle(fontSize: 15),
                                            ),



                                    ),
                                ],
                            ),
                        ),
                    );
                },

                itemCount: KritikSaranAnon.KritikSaranAnonList.length,

            ),
        );
    }
}
