import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numberpicker/numberpicker.dart';

import '../homepage.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  int weightValue = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/homephoto1.png'),
                  fit: BoxFit.cover),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 11, sigmaY: 11),
              child: Container(
                color: Colors.white.withOpacity(.123),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "How much is your weight?",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberPicker(
                      minValue: 30,
                      maxValue: 210,
                      value: weightValue,
                      textStyle:
                          const TextStyle(color: Colors.grey, fontSize: 19),
                      selectedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          weightValue = value;
                        });
                      }),
                  const Text(
                    "kg",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          await FirebaseFirestore.instance
                              .collection('Person')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({'weight': weightValue}).then((value) =>
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return const HomePage();
                                    },
                                  ), (route) => false));
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(color: Colors.black),
                        ))),
              )
            ],
          )
        ],
      ),
    );
  }
}
