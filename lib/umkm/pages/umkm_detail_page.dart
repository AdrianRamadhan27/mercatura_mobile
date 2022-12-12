import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:mercatura/custom_widgets/drawer_widget.dart';
import 'package:mercatura/umkm/models/umkm.dart';
import 'package:mercatura/umkm/api/umkm_api.dart';




class UmkmDetailPage extends StatefulWidget {
  const UmkmDetailPage({super.key, required this.id});
  final int id;

  @override
  State<UmkmDetailPage> createState() => _UmkmDetailPageState();
}

class _UmkmDetailPageState extends State<UmkmDetailPage> {
  late Future<Umkm> futureUmkmDetail;


  @override
  void initState() {
    super.initState();
    final request = Provider.of<CookieRequest>(context, listen: false);
    futureUmkmDetail = fetchUmkmDetail(request, widget.id);

  }

  void refresh() {
    final request = Provider.of<CookieRequest>(context, listen: false);
    setState(() {

      futureUmkmDetail = fetchUmkmDetail(request, widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail UMKM", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      drawer: const DrawerWidget(),
      body: FutureBuilder(
        future: futureUmkmDetail,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                Expanded(flex: 2, child: _TopPortion(umkmDetail: snapshot.data,)),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                            children: [
                              Text(
                                snapshot.data.fields.namaUsaha,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30
                                  )
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      const Icon(Icons.location_pin),
                                      Text(snapshot.data.fields.lokasiUsaha, style: GoogleFonts.poppins())
                                    ]
                                  ),
                                  const SizedBox(width: 10),
                                  Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        const Icon(Icons.email),
                                        Text(snapshot.data.fields.emailUsaha, style: GoogleFonts.poppins())
                                      ]
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  child:  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:  Text(snapshot.data.fields.deskripsiUsaha,
                                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                                        textAlign: TextAlign.center,),
                                    ),
                                  )),
                              const SizedBox(height: 16),

                              Wrap(
                                runSpacing: 12,
                                alignment: WrapAlignment.center,
                                children: [
                                  FloatingActionButton.extended(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    heroTag: 'back',
                                    elevation: 0,
                                    label: Text("Kembali", style: GoogleFonts.poppins(fontSize: 12)),
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                  const SizedBox(width: 16.0),
                                  FloatingActionButton.extended(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: snapshot.data.fields.websiteUsaha));
                                      scaffoldMessenger.showSnackBar(const SnackBar(content: Text("Url Website Copied")));
                                    },
                                    heroTag: 'url',
                                    elevation: 0,
                                    label: Text("Copy Url Website", style: GoogleFonts.poppins(fontSize: 12)),
                                    icon: const Icon(Icons.copy),
                                  ),
                                  const SizedBox(width: 16.0),
                                  (request.cookies['user'] == snapshot.data.fields.pemilikUsaha) ?
                                  FloatingActionButton.extended(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/update_umkm', arguments: snapshot.data).then((_) {
                                        refresh();
                                      });
                                    },
                                    heroTag: 'edit',
                                    elevation: 0,
                                    label:  Text("Edit", style: GoogleFonts.poppins(fontSize: 12)),
                                    icon: const Icon(Icons.edit),
                                  ) :
                                  Container(),
                                ],
                              ),
                            ],
                          ),
                  ),
                )
              ],
                          );
          }
        },
      ),
    );
  }
}



class _TopPortion extends StatelessWidget {
  const _TopPortion({required this.umkmDetail});
  final Umkm umkmDetail;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.purple,Color.fromRGBO(94, 35, 157, 1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            umkmDetail.fields.logoUsaha)),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child:  Container(
                      decoration: BoxDecoration(
                          color: (umkmDetail.fields.bidangUsaha == "Agribisnis") ?
                          Colors.green : (umkmDetail.fields.bidangUsaha == "Kuliner") ?
                          Colors.orange :
                          Colors.red,
                          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:  Center(
                          child: Text("#${umkmDetail.fields.bidangUsaha}",
                            style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                            textAlign: TextAlign.center,),
                        ),
                      )),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}