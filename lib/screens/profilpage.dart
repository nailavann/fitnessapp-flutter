import 'dart:ui';

import 'package:fitnessapp_flutter/models/user_model.dart';
import 'package:fitnessapp_flutter/services/auth.dart';
import 'package:flutter/material.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/homephoto1.png'),
                fit: BoxFit.cover),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              color: Colors.white.withOpacity(.123),
            ),
          ),
        ),
        FutureBuilder<UserModel>(
          future: AuthService.getUserDetails(),
          builder: (context, snapshot) {
            UserModel user = snapshot.data!;
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Username",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextFieldGenerator(text: user.username),
                  const Text("Email", style: TextStyle(color: Colors.white)),
                  TextFieldGenerator(
                    text: user.email,
                  ),
                  const Text("Gender", style: TextStyle(color: Colors.white)),
                  TextFieldGenerator(
                    text: user.gender,
                  ),
                  const Text("Age", style: TextStyle(color: Colors.white)),
                  TextFieldGenerator(
                    text: user.age.toString(),
                  ),
                  const Text("Height", style: TextStyle(color: Colors.white)),
                  TextFieldGenerator(
                    text: user.height.toString(),
                  ),
                  const Text("Weight", style: TextStyle(color: Colors.white)),
                  TextFieldGenerator(
                    text: user.weight.toString(),
                  ),
                ],
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        )
      ]),
    );
  }
}

class TextFieldGenerator extends StatelessWidget {
  String? text;
  TextFieldGenerator({Key? key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 11.0, right: 11, top: 12, bottom: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
              label: Center(child: Text(text!)),
              labelStyle: const TextStyle(color: Colors.white),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
              )),
        ),
      ),
    );
  }
}
