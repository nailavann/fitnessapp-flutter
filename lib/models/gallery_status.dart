import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  String id;
  String image;

  Status({required this.id, required this.image});

  factory Status.fromSnapshot(DocumentSnapshot snapshot) {
    return Status(
      id: snapshot.id,
      image: snapshot["image"],
    );
  }
}
