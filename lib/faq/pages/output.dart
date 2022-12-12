import 'package:mercatura/custom_widgets/drawer_widget.dart';
import 'package:mercatura/faq/models/faq.dart';
import 'package:mercatura/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mercatura/faq/pages/forms.dart';
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
        title: Text('Tambah Budget'),
      ),
      drawer: DrawerWidget(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
                    children: const [
                      Text(
                        "Tidak ada watch list :(",
                        style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return SingleChildScrollView(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(10),
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromARGB(255, 171, 210, 249),
                                  width: 3),
                              borderRadius: BorderRadius.all(Radius.circular(15))),
                          shadowColor: Colors.green[100],
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                    IconData(0xe3f8, fontFamily: 'MaterialIcons'),
                                    color: Colors.cyan,
                                    size: 45),
                                title: Padding(
                                  padding: EdgeInsets.all(7.0),
                                  child: Text(snapshot.data[index].fields.user,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 20.0)),
                                ),
                                subtitle: Text(
                                  'Input            : ' +
                                      snapshot.data[index].fields.title +
                                      '\n' +
                                      'Jenis    : ' +
                                      snapshot.data[index].fields.description,
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}