import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp_flutter/screens/features/heightpage.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class AgePage extends StatefulWidget {
  const AgePage({Key? key}) : super(key: key);

  @override
  _AgePageState createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  int ageValue = 0;

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
                "How old are you?",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              NumberPicker(
                  minValue: 0,
                  maxValue: 150,
                  value: ageValue,
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 19),
                  selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    setState(() {
                      ageValue = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () async {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const HeightPage();
                            },
                          ));

                          await FirebaseFirestore.instance
                              .collection('Person')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({'age': ageValue});
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
