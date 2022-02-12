import 'dart:ui';

import 'package:fitnessapp_flutter/const/hive_const.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'activity_detail.dart';

class ExerciseActivity extends StatefulWidget {
  var bodyListDetail;
  var bodyList;
  ExerciseActivity(
      {Key? key, required this.bodyListDetail, required this.bodyList})
      : super(key: key);

  @override
  _ExerciseActivityState createState() =>
      // ignore: no_logic_in_create_state
      _ExerciseActivityState(bodyListDetail, bodyList);
}

class _ExerciseActivityState extends State<ExerciseActivity> {
  final bodyListDetail;
  final bodyList;
  _ExerciseActivityState(this.bodyListDetail, this.bodyList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(bodyList.vucutBolge)),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/araplan.png'),
                    fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  color: Colors.white.withOpacity(.123),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1, color: Colors.grey),
                shrinkWrap: true,
                itemCount: bodyListDetail.length,
                itemBuilder: (context, index) {
                  var bodyDetail = bodyListDetail[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ActivityDetail(
                                bodyListDetail: bodyDetail, index: index),
                          ));
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 6,
                            top: 5,
                            bottom: 5,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                                height: 60,
                                child: Image.asset(bodyDetail.foto[0])),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            bodyDetail.hareketAdi,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
