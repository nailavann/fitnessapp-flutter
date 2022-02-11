import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/photo_service.dart';

class AddPhotoPage extends StatefulWidget {
  const AddPhotoPage({Key? key}) : super(key: key);

  @override
  _AddPhotoPageState createState() => _AddPhotoPageState();
}

class _AddPhotoPageState extends State<AddPhotoPage> {
  final PhotoService _photoService = PhotoService();

  final ImagePicker _imagePicker = ImagePicker();
  var _pickImage;
  var _profileImage;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String? name;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Widget? imagePlace() {
    if (_profileImage != null) {
      return Image(
        image: FileImage(File(_profileImage!.path)),
        height: MediaQuery.of(context).size.height * 0.4,
      );
    } else {
      if (_pickImage != null) {
        return CircleAvatar(
          backgroundImage: NetworkImage(_pickImage),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    firebaseFirestore
        .collection("Person")
        .doc(firebaseAuth.currentUser!.uid)
        .get()
        .then((value) => name = value.data()!['username']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("add_photo").tr(),
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
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                color: Colors.white.withOpacity(.123),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(child: imagePlace()),
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () =>
                            imageSource(ImageSource.camera, context: context),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () =>
                            imageSource(ImageSource.gallery, context: context),
                        child: const Icon(
                          Icons.image,
                          size: 30,
                          color: Colors.white,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    _photoService.addPhoto(_profileImage, name.toString()).then(
                        (value) =>
                            Fluttertoast.showToast(msg: "Fotoğraf eklendi!"));
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 26.0, top: 10, bottom: 10, right: 26),
                      child: const Text("add").tr(),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void imageSource(ImageSource source, {required BuildContext context}) async {
    try {
      final pickedFile = await _imagePicker.pickImage(source: source);
      setState(() {
        _profileImage = pickedFile;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
