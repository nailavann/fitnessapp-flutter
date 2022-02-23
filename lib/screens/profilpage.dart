import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessapp_flutter/models/user_model.dart';
import 'package:fitnessapp_flutter/services/auth.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_textfield.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
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
            UserModel? user = snapshot.data;
            if (snapshot.hasData) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      const Text(
                        "Username",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      TextFieldGenerator(text: user?.username),
                      const Text("Email",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      TextFieldGenerator(
                        text: user?.email,
                      ),
                      const Text("Gender",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      TextFieldGenerator(
                        text: user?.gender,
                      ),
                      const Text("Age",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      TextFieldGenerator(
                        text: user?.age.toString(),
                      ),
                      const Text("Height",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      TextFieldGenerator(
                        text: user?.height.toString(),
                      ),
                      const Text("Weight",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      TextFieldGenerator(
                        text: user?.weight.toString(),
                      ),
                      const Text("Kayıt olma tarihi",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      TextFieldGenerator(
                        text: DateFormat.yMd().format(user?.date.toDate()),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        )
      ]),
    );
  }
}
