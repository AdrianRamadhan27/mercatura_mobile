import 'package:counter_7/utils/drawer.dart';
import 'package:mercatura/faq/models/faq.dart';
import 'package:mercatura/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mercatura/faq/pages/forms.dart';

class FaqOutputPage extends StatelessWidget {
  const FaqOutputPage({super.key});

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
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                for (var item in listModel)
                  Card(
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
                            child: Text(item.user,
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20.0)),
                          ),
                          subtitle: Text(
                            'Input            : ' +
                                item.title +
                                '\n' +
                                'Jenis    : ' +
                                item.description,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}