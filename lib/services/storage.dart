import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadPhoto(File file) async {
    var uploadPhoto = _firebaseStorage
        .ref()
        .child(
            "${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}")
        .putFile(file);

    uploadPhoto.snapshotEvents.listen((event) {});

    var storage = await uploadPhoto;

    return await storage.ref.getDownloadURL();
  }
}
