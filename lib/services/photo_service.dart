import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitnessapp_flutter/services/auth.dart';
import 'package:fitnessapp_flutter/services/storage.dart';

import 'package:image_picker/image_picker.dart';

import '../models/gallery_status.dart';

class PhotoService {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final StorageService _storageService = StorageService();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String photoUrl = "";
  String profilPhotoUrl = "";

  Future<Status> addGalleryPhoto(
      XFile xFile, String username, String desc) async {
    var ref = _firebaseFirestore.collection("Photo");

    photoUrl = await _storageService.uploadPhoto(
      File(xFile.path),
    );

    await _firebaseFirestore
        .collection("Person")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      profilPhotoUrl = value.data()!['photoUrl'];
    });

    var document = await ref.add({
      'photo': photoUrl,
      'username': username,
      'desc': desc,
      'date': DateTime.now(),
      'profilPhotoUrl': profilPhotoUrl
    });

    return Status(id: document.id, image: photoUrl, desc: desc);
  }

  Future addProfilPhoto(XFile xFile) async {
    var ref = _firebaseFirestore.collection('Person');
    photoUrl = await _storageService.uploadPhoto(File(xFile.path));

    var document = await ref
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'photoUrl': photoUrl});
  }

  static Stream<QuerySnapshot> viewPhoto() {
    var ref = _firebaseFirestore
        .collection("Photo")
        .orderBy("date", descending: true)
        .snapshots();

    return ref;
  }
}
