import 'package:flutter/material.dart';
import 'package:mercatura/config/api_config.dart';
import 'package:mercatura/custom_widgets/mydrawer.dart';

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    final Map<String, dynamic> response = await request.post("$apiUrl/auth/register/", {
      'username': _username,
      'password1': _password1,
      'password2': _password2,
    });
    request.headers["X-CSRFToken"] = request.cookies["csrftoken"] ?? "";
    request.headers["Referer"] = apiUrl;
    if (!mounted) return;
    if (response["status"]) {
      final snackBar = SnackBar(content: Text(response["message"]));
      scaffoldMessenger.showSnackBar(snackBar);
      Navigator.of(context).pushReplacementNamed("/login");
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
  String _password2 = "";



  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    // The rest of your widgets are down below
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Text("Register"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Konfirmasi Password",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _password2 = value!;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _password2 = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Mohon isi ulang password!';
                            }
                            if (value != _password1) {
                              return 'Password tidak sama';
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
                          child: const Text("Submit")),
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
          Row(
            children: [
              Text('Sudah Punya Akun?'),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/login");
                },
                child: Text("Login"),
              )
            ],
          )
        ],
      ),
    );
  }
}