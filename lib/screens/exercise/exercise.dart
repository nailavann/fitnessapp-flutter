import 'dart:convert';
import 'dart:ui';
import 'package:fitnessapp_flutter/models/exercise_model.dart';

import 'package:flutter/material.dart';

import 'exercise_activity.dart';

class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  List<Body>? bodyList;

  verileriOku() async {
    String okunanString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/veriler.json');

    var jsonObject = json.decode(okunanString);

    List<Body> tempList =
        (jsonObject as List).map((e) => Body.fromMap(e)).toList();

    setState(() {
      bodyList = tempList;
    });
  }

  @override
  void initState() {
    verileriOku() ?? const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
        body: bodyList == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/img/araplan.png'),
                          fit: BoxFit.cover),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        color: Colors.white.withOpacity(.123),
                      ),
                    ),
                  ),
                  Positioned(
                      child: ListView.builder(
                    itemCount: bodyList!.length,
                    itemBuilder: (context, index) {
                      var body = bodyList![index];
                      return bodyList == null
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, right: 5.0, top: 3),
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ExerciseActivity(
                                                  bodyListDetail:
                                                      body.vucutDetay,
                                                  bodyList: body),
                                        ));
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 13.0, top: 5, bottom: 5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Container(
                                              height: 60,
                                              child:
                                                  Image.asset(body.vucutFoto)),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        body.vucutBolge,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                  ))
                ],
              ));
  }
}
