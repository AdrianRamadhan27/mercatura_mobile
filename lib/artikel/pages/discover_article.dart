import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mercatura/artikel/widget/image_container.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import "../../custom_widgets/mydrawer.dart";
import '../models/article.dart';
import '../widget/drawer.dart';
import '../utils/fetch_article.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  final Future<List<Article>> future = fetchArticle();

  String dateFormatter(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
  final request = context.watch<CookieRequest>();
    // future.then((value){
    //   log(articleToJson(value));
    // });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/artikel');
          },
        ),
        title: Text(
          'List Artikel',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black, 
              fontWeight: FontWeight.bold,
              fontSize: 24
            )
          ),
        ),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: FutureBuilder<List<Article>>(
          future: future,
          builder: (context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: [
                    Text(
                      "Oh no! Tidak ada watch list :(",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                        color: Colors.black, 
                        fontSize: 20)
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView(
                  // scrollDirection: Axis.vertical,
                  // physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20.0),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Mercatura menyediakan informasi seputar UMKM yang dirangkum dalam kumpulan artikel yang menarik.',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.grey.shade600, 
                              fontWeight: FontWeight.w400,
                              fontSize: 14
                            )
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          // height: MediaQuery.of(context).size.,
                          child: ListView.builder(
                            // scrollDirection: Axis.vertical,
                            // physics: const AlwaysScrollableScrollPhysics(),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context, 
                                    '/artikel/detail',
                                    arguments: snapshot.data![index]
                                  );
                                },
                                child: Row(
                                  children: [
                                    ImageContainer(opacity: 0, width: 100, height: 100, margin: const EdgeInsets.all(10.0), borderRadius: 5, imageUrl: snapshot.data![index].imageUrl),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data![index].title,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Colors.black, 
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14
                                              )
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.date_range_rounded,
                                                size: 18,
                                                color: Colors.grey.shade600,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                dateFormatter(snapshot.data![index].date),                                  
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                    color: Colors.grey.shade600, 
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12
                                                  )
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                          ),
                        )
                      ],
                    )
                  ],
                );
              }
            }
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(94, 35, 157, 1),
        foregroundColor: Colors.white,
        tooltip: "Tambah artikel",
        elevation: 10.0,
        child: Text(
          "+",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            )
          ),
        ),
        onPressed: () {
          if (request.loggedIn == false) {
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            Navigator.pushReplacementNamed(context, '/artikel/create');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
