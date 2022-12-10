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
      ),
      extendBodyBehindAppBar: true,
      drawer: buildDrawer(context),
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
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(
                  article.title,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    height: 1.25
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.date_range_rounded,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      dateFormatter(article.date),                                  
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.grey.shade600, 
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        )
                      ),
                    ),
                    const SizedBox(width: 150),
                    Icon(
                      Icons.person,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      article.author[0],                                  
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.grey.shade600, 
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
