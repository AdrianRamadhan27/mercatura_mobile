import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mercatura/artikel/widget/image_container.dart';
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
    // future.then((value){
    //   log(articleToJson(value));
    // });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: buildDrawer(context),
      body: FutureBuilder<List<Article>>(
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
                padding: const EdgeInsets.all(20.0),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'List Artikel',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black, 
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                          )
                        ),
                      ),
                      const SizedBox(height: 5),
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
                      ListView.builder(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapshot.data![index].title,
                                        maxLines: 4,
                                        overflow: TextOverflow.clip,
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
                                )
                              ],
                            ),
                          );
                        })
                      )
                    ],
                  )
                ],
              );
            }
          }
        }
      )
    );
  }
}