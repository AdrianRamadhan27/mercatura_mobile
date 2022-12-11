import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mercatura/config/api_config.dart';
import 'package:mercatura/custom_widgets/mydrawer.dart';
import 'package:mercatura/umkm/models/umkm.dart';
import 'package:mercatura/umkm/api/umkm_api.dart';


import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class UmkmDetailPage extends StatefulWidget {
  UmkmDetailPage({super.key, required this.id});
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
        title: const Text("Detail UMKM"),
      ),
      drawer: const MyDrawer(),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Icon(Icons.location_pin),
                                      Text(snapshot.data.fields.lokasiUsaha)
                                    ]
                                  ),
                                  SizedBox(width: 10),
                                  Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      children: [
                                        Icon(Icons.email),
                                        Text(snapshot.data.fields.emailUsaha)
                                      ]
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.pink,
                                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                  child: new Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: new Text(snapshot.data.fields.deskripsiUsaha,
                                        style: TextStyle(color: Colors.white, fontSize: 12),
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
                                    label: const Text("Kembali"),
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                  const SizedBox(width: 16.0),
                                  FloatingActionButton.extended(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: snapshot.data.fields.websiteUsaha));
                                      scaffoldMessenger.showSnackBar(SnackBar(content: Text("Url Website Copied")));
                                    },
                                    heroTag: 'url',
                                    elevation: 0,
                                    label: const Text("Copy Url Website"),
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
                                    label: const Text("Edit"),
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
  _TopPortion({super.key, required this.umkmDetail});
  Umkm umkmDetail;

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
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
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

                    color: Colors.transparent,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(8.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new Center(
                            child: new Text("#" + umkmDetail.fields.bidangUsaha,
                              style: TextStyle(color: Colors.white, fontSize: 12),
                              textAlign: TextAlign.center,),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}