import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void dialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("are_you_sure").tr(),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("no").tr()),
            TextButton(
                onPressed: () {
                  AuthService.signOut(context);
                },
                child: const Text("yes").tr())
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Stack(
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
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                  onPressed: () {
                    dialog();
                  },
                  child: const Text("logout").tr()),
            )
          ],
        ),
      ),
    );
  }
}
