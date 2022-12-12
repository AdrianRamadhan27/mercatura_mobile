import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mercatura/api/pengguna_api.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Drawer(
      child: Container(
        color: const Color.fromRGBO(94, 35, 157, 1),
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(
                  "M e r c a t u r a",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Color.fromARGB(255, 251, 130, 204)),
              title: Text(
                "Home",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.of(context).pushReplacementNamed("/home");
              },
            ),
            ListTile(
              leading: const Icon(Icons.article, color: Color.fromARGB(255, 250, 124, 223)),
              title: Text(
                "Artikel",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.of(context).pushReplacementNamed("/home");
              },
            ),
            ListTile(
              leading: const Icon(Icons.store, color: Color.fromARGB(255, 250, 124, 223)),
              title: Text(
                "Daftar UMKM",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.of(context).pushReplacementNamed("/home");
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_rounded, color: Color.fromARGB(255, 250, 124, 223)),
              title: Text(
                "Kritik & Saran",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.of(context).pushReplacementNamed("/home");
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat_rounded, color: Color.fromARGB(255, 250, 124, 223)),
              title: Text(
                "FAQ",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Route menu ke halaman utama
                Navigator.of(context).pushReplacementNamed("/faq");
              },
            ),
            ListTile(
              leading: request.loggedIn? const Icon(Icons.logout_outlined, color: Color.fromARGB(255, 250, 124, 223)) : const Icon(Icons.login_rounded, color: Color.fromARGB(255, 250, 124, 223)),
              title: request.loggedIn? Text(
                "Logout",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ): Text(
                "Login",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                // Route menu ke halaman login atau logout
                if(request.loggedIn) {
                  logout(request);
                  const snackBar = SnackBar(content: Text("Berhasil logout!"));
                  scaffoldMessenger.showSnackBar(snackBar);
                  Navigator.of(context).pushReplacementNamed("/login");
                } else {
                  Navigator.of(context).pushReplacementNamed("/login");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}