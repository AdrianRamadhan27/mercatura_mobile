import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mercatura/config/api_config.dart';
import 'package:mercatura/custom_widgets/drawer_widget.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  bool isLoading = false;

  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  Future<void> _onSubmitBtnPressed(CookieRequest request,
      ScaffoldMessengerState scaffoldMessenger) async {
    setState(() {
      isLoading = true;
    });
    // 'username' and 'password' should be the values of the user login form.
    final response = await request.login("$apiUrl/auth/login/", {
      'username': _username,
      'password': _password1,
    });
    request.headers["X-CSRFToken"] = request.cookies["csrftoken"] ?? "";
    request.headers["Referer"] = apiUrl;
    if (!mounted) return;
    if (request.loggedIn) {
      String username = response["user"];
      request.cookies["user"] = username;
      scaffoldMessenger.showSnackBar(SnackBar(content: Text("Berhasil login sebagai $username")));
      Navigator.of(context).pushReplacementNamed("/home");
    } else {
      final snackBar = SnackBar(content: Text(response["message"]));
      scaffoldMessenger.showSnackBar(snackBar);
    }
    setState(() {
      isLoading = false;
    });
  }

  String _username = "";
  String _password1 = "";


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // The rest of your widgets are down below
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mercatura",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold
            )
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30,),
          Text(
            "L O G I N",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color.fromRGBO(94, 35, 157, 1),
                fontSize: 30,
                fontWeight: FontWeight.bold
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: GoogleFonts.poppins(),
                          decoration: const InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _username = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _username = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Username tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _password1 = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _password1 = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Password tidak boleh kosong!';
                            }
                            return null;
                          },
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              _onSubmitBtnPressed(request, scaffoldMessenger);
                            }
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              )
                            ),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      if (isLoading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Text(
                'Belum Punya Akun?',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                  )
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/register");
                },
                child: Text(
                  "Register", 
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Color.fromRGBO(94, 35, 157, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),

              )
            ],
          )
        ],
      ),
    );
  }
}