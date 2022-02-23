import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../../services/photo_service.dart';
import 'addphotopage.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  String? username;
  String? photoUrl;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("gallery").tr(),
        centerTitle: true,
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
              filter: ImageFilter.blur(sigmaX: 17, sigmaY: 17),
              child: Container(
                color: Colors.white.withOpacity(.123),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: PhotoService.viewPhoto(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var photo = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(150),
                                    child: Image.network(
                                      photo['profilPhotoUrl'].toString(),
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    photo["username"],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: size.width * 0.9,
                                height: size.height * 0.5,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(photo['photo']),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  photo['desc'],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  DateFormat.yMd()
                                      .format((photo['date']).toDate()),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                            ],
                          ),
                        );
                      },
                    );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPhotoPage(),
              ));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
