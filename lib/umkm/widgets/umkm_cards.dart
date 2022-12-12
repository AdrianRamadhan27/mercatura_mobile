
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:mercatura/umkm/models/umkm.dart';



class UmkmCards extends StatelessWidget {
  const UmkmCards({super.key, required this.umkmList, required this.refreshFunction});

  final List<Umkm> umkmList;
  final Function refreshFunction;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    // TODO: implement build
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: umkmList.length,
        itemBuilder: (_, index)=> Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading:  Container(
                      width: 100,
                      padding: const EdgeInsets.all(1.0),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/detail_umkm', arguments: umkmList[index].pk);
                          },
                          child:CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(umkmList[index].fields.logoUsaha),
                          ),
                        ),
                      ),
          ),
                title: Text(umkmList[index].fields.namaUsaha,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                color: (umkmList[index].fields.bidangUsaha == "Agribisnis") ?
                                Colors.green : (umkmList[index].fields.bidangUsaha == "Kuliner") ?
                                Colors.orange :
                                Colors.red,
                                borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child:  Center(
                                child:  Text("#${umkmList[index].fields.bidangUsaha}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(Icons.location_pin, color: Colors.cyan,),
                          Text(umkmList[index].fields.lokasiUsaha,
                            style: GoogleFonts.poppins())
                        ]
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child:  Text('Detail',
                        style: GoogleFonts.poppins()),
                    onPressed: () {
                      Navigator.pushNamed(context, '/detail_umkm', arguments: umkmList[index].pk);
                    },
                  ),
                  const SizedBox(width: 8),
                  (request.cookies['user'] == umkmList[index].fields.pemilikUsaha) ?
                  TextButton(
                    child: Text('Edit',
                        style: GoogleFonts.poppins()),
                    onPressed: () {
                      Navigator.pushNamed(context, '/update_umkm', arguments: umkmList[index]).then((_) {
                        refreshFunction();
                      });
                    },
                  ) :
                  Container(),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        )
    );
  }
}