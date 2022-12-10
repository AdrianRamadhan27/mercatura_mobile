import 'package:flutter/material.dart';
import '../models/article.dart';
import 'image_container.dart';
import 'custom_tag.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtikelTerbaru extends StatelessWidget {
  const ArtikelTerbaru({
    Key? key,
    required this.articles
  }) : super(key: key);

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
      height: MediaQuery.of(context).size.height * 0.45,
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      opacity: 0.5,
      imageUrl:articles[0].imageUrl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTag(
            backgroundColor: Colors.grey.withAlpha(150), 
            children: [
              Text(
                "Artikel terbaru",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]
          ),
          const SizedBox(height: 10),
          Text(
            articles[0].title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              height: 1.25
            ),
          ),
          TextButton(
            onPressed: () {}, 
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero
            ),
            child: Row(
              children: [
                Text(
                  "Learn more",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.arrow_right_alt, 
                  color: Colors.white
                )
              ],
            )
          )
        ],
      ),
    );
  }
}