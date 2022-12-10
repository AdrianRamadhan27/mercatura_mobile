import 'package:flutter/material.dart';
import 'package:mercatura/config/api_config.dart';
import 'package:mercatura/custom_widgets/mydrawer.dart';
import 'package:mercatura/umkm/models/umkm.dart';
import 'package:mercatura/umkm/api/umkm_api.dart';


import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


class UmkmDetailPage extends StatefulWidget {
  const UmkmDetailPage({super.key, required this.id});
  final int id;

  @override
  State<UmkmDetailPage> createState() => _UmkmDetailPageState();
}

class _UmkmDetailPageState extends State<UmkmDetailPage> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isLoading = false;


  late Future<Umkm> futureUmkmDetail;


  @override
  void initState() {
    super.initState();
    final request = Provider.of<CookieRequest>(context, listen: false);
    futureUmkmDetail = fetchUmkmDetail(request, widget.id);

  }




  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();


    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // The rest of your widgets are down below
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail UMKM"),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FutureBuilder(
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
                        Text(snapshot.data.fields.namaUsaha),
                        (request.cookies["user"] == snapshot.data.fields.pemilikUsaha) ?
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/update_umkm", arguments:snapshot.data);
                                },
                                child: const Text("Edit"))
                            :
                            Container(),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/umkm');
                            },
                            child: Text("Kembali"))
                      ],
                    );
                  }
                }
              ),
            ),
          ),

        ],
      ),
    );
  }
}