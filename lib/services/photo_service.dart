import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp_flutter/services/storage.dart';

import 'package:image_picker/image_picker.dart';

import '../models/gallery_status.dart';

class PhotoService {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;
  static final StorageService _storageService = StorageService();

  String photoUrl = "";

  Future<Status> addPhoto(XFile xFile, String username) async {
    var ref = _firebaseFirestore.collection("Photo");

    photoUrl = await _storageService.uploadPhoto(File(xFile.path));

    var document = await ref.add({'photo': photoUrl, 'username': username});

    return Status(id: document.id, image: photoUrl);
  }

  static Stream<QuerySnapshot> viewPhoto() {
    var ref = _firebaseFirestore.collection("Photo").snapshots();

    return ref;
  }
}
