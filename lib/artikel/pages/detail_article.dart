import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mercatura/artikel/widget/image_container.dart';
import '../models/article.dart';
import '../widget/custom_tag.dart';
import '../widget/drawer.dart';
import '../utils/fetch_article.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({super.key});

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  @override
  Widget build(BuildContext context) {
    final Article article = ModalRoute.of(context)!.settings.arguments as Article;

     String dateFormatter(DateTime date) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(date);
      return formatted;
    }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(94, 35, 157, 1),
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ImageContainer(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity, 
            opacity: 0, 
            imageUrl: article.imageUrl,
            borderRadius: 0.0,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    article.title,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 49, 19, 82), 
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.date_range_rounded,
                      size: 20,
                      color: Color.fromRGBO(94, 35, 157, 1),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      dateFormatter(article.date),                                  
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(94, 35, 157, 1), 
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        )
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.person,
                      size: 20,
                      color: Color.fromRGBO(94, 35, 157, 1),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      article.author[0],                                  
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(94, 35, 157, 1), 
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        )
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        article.description,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.black, 
                            fontWeight: FontWeight.normal,
                            fontSize: 18
                          )
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          )
        ],
      ),
     );
  }
}
