import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String id;
  String image;
  String desc;

  Status({required this.id, required this.image, required this.desc});

  factory Status.fromSnapshot(DocumentSnapshot snapshot) {
    return Status(
        id: snapshot.id, image: snapshot["image"], desc: snapshot['desc']);
  }
}
