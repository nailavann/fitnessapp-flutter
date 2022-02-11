import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessapp_flutter/screens/startpage.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../services/auth.dart';
import 'loginpage.dart';

late TextEditingController _emailController;
late TextEditingController _passwordController;
late TextEditingController _usernameController;
GlobalKey<FormState> _key = GlobalKey<FormState>();

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
    ProgressDialog pr = ProgressDialog(context: context);

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
              height: 40,
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
                      validator: (username) {
                        if (username!.isEmpty) {
                          return "Lütfen kullanıcı adını giriniz!";
                        } else {
                          return null;
                        }
                      },
                      controller: _usernameController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          errorBorder: const OutlineInputBorder(),
                          labelText: "username".tr(),
                          labelStyle: const TextStyle(color: Colors.black)),
                    ),
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
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          errorBorder: const OutlineInputBorder(),
                          labelText: "email".tr(),
                          labelStyle: const TextStyle(color: Colors.black)),
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
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.password,
                            color: Colors.black,
                          ),
                          enabledBorder: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          errorBorder: const OutlineInputBorder(),
                          labelText: "password".tr(),
                          labelStyle: const TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          pr.show(max: 10000, msg: "pr_register".tr());
                          AuthService.createAccount(
                                  _emailController.text,
                                  _passwordController.text,
                                  _usernameController.text)
                              .then((value) => value == null
                                  ? null
                                  : Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                      (route) => false))
                              .whenComplete(() => pr.close());
                        }
                      },
                      child: const Text("register").tr()),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    child: const Text(
                      "want_login",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ).tr(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
