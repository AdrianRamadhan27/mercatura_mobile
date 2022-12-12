import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/article.dart';
import 'image_container.dart';
import 'package:google_fonts/google_fonts.dart';

class KumpulanArtikel extends StatelessWidget {
  const KumpulanArtikel({
    Key? key,
    required this.articles
  }) : super(key: key);

  final List<Article> articles;

  String dateFormatter(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kumpulan Artikel",
                style: GoogleFonts.poppins(
                  color: const Color.fromARGB(255, 49, 19, 82),
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context, 
                    '/artikel/discover',
                  );
                }, 
                child: Text(
                  "More",
                  style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 110, 19, 54),
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        '/artikel/detail',
                        arguments: articles[index]
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageContainer(
                          opacity: 0, 
                          width: MediaQuery.of(context).size.width * 0.5, 
                          imageUrl: articles[index].imageUrl
                        ),
                        const SizedBox(height: 10),
                        Text(
                          articles[index].title,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            color: const Color.fromRGBO(94, 35, 157, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            height: 1.5
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'dibuat pada ${dateFormatter(articles[index].date)}',
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'oleh ${articles[index].author[0]}',
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}