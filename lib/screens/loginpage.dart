import 'dart:ui';

import 'package:fitnessapp_flutter/screens/registerpage.dart';
import 'package:fitnessapp_flutter/screens/startpage.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import 'homepage.dart';

late TextEditingController _emailController;
late TextEditingController _passwordController;
late TextEditingController _usernameController;
GlobalKey<FormState> _key = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const StartPage(),
                ));
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      backgroundColor: const Color(0xffdfe6e9),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Form(
              key: _key,
              child: Column(
                children: [
                  Image.asset('assets/img/loginregisterphoto.png',
                      width: 200, height: 200),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, bottom: 12),
                    child: TextFormField(
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Lütfen email giriniz!";
                        } else {
                          return null;
                        }
                      },
                      controller: _emailController,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: TextFormField(
                      validator: (password) {
                        if (password!.isEmpty) {
                          return "Lütfen parola giriniz";
                        } else if (password.length < 6) {
                          return "Parola 6 haneden az olamaz!";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(),
                          prefixIcon: Icon(
                            Icons.security,
                            color: Colors.black,
                          ),
                          labelText: "Şifre",
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        AuthService.signIn(
                                _emailController.text, _passwordController.text)
                            .then((value) => value == null
                                ? null
                                : Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                    (route) => false));
                      }
                    },
                    child: const Text("Giriş Yap"),
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                      child: const Text(
                        "Henüz kayıt olmadınız mı?",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ));
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
