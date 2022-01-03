import 'dart:ui';

import 'package:fitnessapp_flutter/screens/registerpage.dart';
import 'package:flutter/material.dart';

import 'loginpage.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/arkaplan.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(color: Colors.white.withOpacity(.123)),
          ),
        ),
        Positioned(
            top: 10,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30.0),
                  child: Text(
                    'FULL - BODY \nWORKOUT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                ContainerGenerated("Giriş", const LoginPage()),
                const SizedBox(
                  height: 15,
                ),
                ContainerGenerated("Kayıt", const RegisterPage()),
              ],
            ))
      ],
    ));
  }
}

class ContainerGenerated extends StatelessWidget {
  String text;
  var nextPage;

  ContainerGenerated(
    this.text,
    this.nextPage,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextPage,
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 22.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.6),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
