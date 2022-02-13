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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "How much is your weight?",
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberPicker(
                  minValue: 30,
                  maxValue: 210,
                  value: weightValue,
                  textStyle: TextStyle(color: Colors.grey[400], fontSize: 18),
                  selectedTextStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  onChanged: (value) {
                    setState(() {
                      weightValue = value;
                    });
                  }),
              const Text(
                "kg",
                style: TextStyle(fontSize: 18),
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
                    child: const Text("Next"))),
          )
        ],
      ),
    );
  }
}
