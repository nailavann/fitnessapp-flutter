import 'package:cloud_firestore/cloud_firestore.dart';

class PersonService {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  static Stream<QuerySnapshot> viewPerson() {
    var ref = _firebaseFirestore.collection("Person").snapshots();

    return ref;
  }
}
