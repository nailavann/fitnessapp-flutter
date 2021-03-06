import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username;
  String? email;
  String? gender;
  int? age;
  int? weight;
  int? height;
  var date;
  String? photoUrl;
  UserModel(
      {this.username,
      this.email,
      this.gender,
      this.age,
      this.weight,
      this.height,
      this.date,
      this.photoUrl});

  factory UserModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        username: snapshot['username'] ?? "",
        email: snapshot['email'] ?? "",
        gender: snapshot['gender'] ?? "",
        age: snapshot['age']?.toInt() ?? 0,
        weight: snapshot['weight']?.toInt() ?? 0,
        height: snapshot['height']?.toInt() ?? 0,
        date: snapshot['registerdate'],
        photoUrl: snapshot['photoUrl']);
  }
}
