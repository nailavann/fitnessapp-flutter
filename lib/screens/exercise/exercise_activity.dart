import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp_flutter/screens/favoritepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:fitnessapp_flutter/models/exercise_model.dart';

import 'activity_detail.dart';

class ExerciseActivity extends StatefulWidget {
  final List bodyListDetail;
  final Body bodyList;

  const ExerciseActivity({
    Key? key,
    required this.bodyListDetail,
    required this.bodyList,
  }) : super(key: key);

  @override
  _ExerciseActivityState createState() =>
      // ignore: no_logic_in_create_state
      _ExerciseActivityState(bodyListDetail, bodyList);
}

class _ExerciseActivityState extends State<ExerciseActivity> {
  List bodyListDetail;
  Body bodyList;
  _ExerciseActivityState(this.bodyListDetail, this.bodyList);
  Box favoriteBox = Hive.box(FirebaseAuth.instance.currentUser!.uid);

  showDialogss(BuildContext context, var bodyDetail) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Favoriye eklemek istiyor musunuz?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Hayır")),
              TextButton(
                  onPressed: () {
                    if (!favoriteBox
                        .containsKey(bodyDetail.teknik.toString().length)) {
                      favoriteBox
                          .put(bodyDetail.teknik.toString().length,
                              bodyDetail.hareketAdi)
                          .whenComplete(() => Navigator.pop(context));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text("Favorilerde mevcut!!!"),
                            );
                          }).whenComplete(() => Navigator.pop(context));
                    }
                  },
                  child: const Text("Evet"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(favoriteBox.toMap().toString());
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
                  return Slidable(
                    endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.35,
                        children: [
                          SlidableAction(
                            onPressed: (context) =>
                                showDialogss(context, bodyDetail),
                            backgroundColor:
                                const Color.fromARGB(12, 122, 120, 120),
                            foregroundColor: Colors.white,
                            icon: Icons.favorite,
                            label: 'favorite'.tr(),
                          ),
                        ]),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ActivityDetail(bodyListDetail: bodyDetail),
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
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
