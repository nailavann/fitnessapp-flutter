import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp_flutter/screens/features/genderpage.dart';
import 'package:fitnessapp_flutter/services/photo_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class ProfilPhoto extends StatefulWidget {
  const ProfilPhoto({Key? key}) : super(key: key);

  @override
  _ProfilPhotoState createState() => _ProfilPhotoState();
}

class _ProfilPhotoState extends State<ProfilPhoto> {
  final PhotoService _photoService = PhotoService();

  final ImagePicker _imagePicker = ImagePicker();
  dynamic _profileImage;

  void selectImage() async {
    final imageUrl = await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profileImage = imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context: context);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                _profileImage != null
                    ? CircleAvatar(
                        radius: 100,
                        backgroundImage: FileImage(File(_profileImage!.path)),
                      )
                    : const CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            AssetImage("assets/img/profilphoto.png"),
                      ),
                Positioned(
                  bottom: 1,
                  right: -3,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_profileImage != null) {
                          pr.show(max: 1000, msg: "Fotoğraf yükleniyor...");
                          await _photoService
                              .addProfilPhoto(_profileImage)
                              .whenComplete(() => pr.close());
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const GenderPage();
                            },
                          ));
                        } else {
                          Fluttertoast.showToast(
                              msg: "Lütfen profil fotoğrafı seçiniz!");
                        }
                      },
                      child: const Text("Next",
                          style: TextStyle(color: Colors.black)))),
            )
          ],
        ),
      ),
    );
  }
}
