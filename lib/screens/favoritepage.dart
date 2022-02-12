import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("favorite").tr(),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
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
          ValueListenableBuilder<Box>(
            valueListenable:
                Hive.box(FirebaseAuth.instance.currentUser!.uid).listenable(),
            builder: (context, value, child) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  var favoriteValue = value.getAt(index);

                  return Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8, top: 15),
                      child: Slidable(
                        endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.35,
                            children: [
                              SlidableAction(
                                onPressed: (context) =>
                                    showDialogss(context, index),
                                backgroundColor:
                                    const Color.fromARGB(0, 122, 120, 120),
                                foregroundColor: Colors.white,
                                icon: Icons.favorite,
                                label: 'favorite'.tr(),
                              ),
                            ]),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 19.0, horizontal: 22.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            favoriteValue,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

void showDialogss(BuildContext context, int index) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("Favoriden çıkartmak istiyor musunuz?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Hayır")),
            TextButton(
                onPressed: () {
                  Hive.box(FirebaseAuth.instance.currentUser!.uid)
                      .deleteAt(index)
                      .whenComplete(() => Navigator.pop(context));
                },
                child: const Text("Evet"))
          ],
        );
      });
}
