import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp_flutter/screens/features/weightpage.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class HeightPage extends StatefulWidget {
  const HeightPage({Key? key}) : super(key: key);

  @override
  _HeightPageState createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  int heightValue = 100;

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
                "How much is your length?",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberPicker(
                      minValue: 100,
                      maxValue: 250,
                      value: heightValue,
                      textStyle:
                          const TextStyle(color: Colors.grey, fontSize: 19),
                      selectedTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                      onChanged: (value) {
                        setState(() {
                          heightValue = value;
                        });
                      }),
                  const Text(
                    "cm",
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
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const WeightPage();
                            },
                          ));
                          await FirebaseFirestore.instance
                              .collection('Person')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({'height': heightValue});
                        },
                        child: const Text("Next",
                            style: TextStyle(color: Colors.black)))),
              )
            ],
          )
        ],
      ),
    );
  }
}
