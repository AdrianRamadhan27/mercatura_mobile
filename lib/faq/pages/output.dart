import 'package:google_fonts/google_fonts.dart';
import 'package:mercatura/custom_widgets/drawer_widget.dart';
import 'package:mercatura/faq/models/faq.dart';
import 'package:flutter/material.dart';
import 'package:mercatura/faq/utils/fetch.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class FaqOutputPage extends StatefulWidget {
  const FaqOutputPage({super.key});

  @override
  State<FaqOutputPage> createState() => _FaqOutputPageState();
}

class _FaqOutputPageState extends State<FaqOutputPage> {
  late Future<List<Faq>> futureFaqList;


  @override
  void initState() {
    super.initState();
    final request = Provider.of<CookieRequest>(context, listen: false);
    futureFaqList = fetchFaq(request);

  }

  void refresh() {
    final request = Provider.of<CookieRequest>(context, listen: false);
    setState(() {

      futureFaqList = fetchFaq(request);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar FAQ',
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      ),
      drawer: const DrawerWidget(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromARGB(255, 197, 226, 255),
                  Color.fromARGB(255, 255, 255, 255),
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: futureFaqList,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        "Tidak ada watch list :(",
                        style: GoogleFonts.poppins(color: const Color(0xff59A5D8), fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: const [
                          ]),
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Text(snapshot.data[index].fields.user,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 30.0)),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Text('Teks: ${snapshot.data[index].fields.title}\n''Tipe: ${snapshot.data[index].fields.description}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 25.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }
}