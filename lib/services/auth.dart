import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/loginpage.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<UserModel> getUserDetails() async {
    DocumentSnapshot snap =
        await _firestore.collection('Person').doc(_auth.currentUser!.uid).get();

    return UserModel.fromSnap(snap);
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: "Geçersiz email!");
      } else if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "Kullanıcı bulunamadı!");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Yanlış şifre!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static signOut(BuildContext context) async {
    return await _auth.signOut().then((value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false));
  }

  static Future<User?> createAccount(
      String email, String password, String username) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firestore
          .collection("Person")
          .doc(user.user!.uid)
          .set({'email': email, 'password': password, 'username': username});
      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "Bu email daha önceden alınmış!");
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: "Geçersiz mail!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
