import 'package:flutter/material.dart';

class TextFieldGenerator extends StatelessWidget {
  String? text;
  TextFieldGenerator({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 11.0, right: 11, top: 12, bottom: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
              label: Center(child: Text(text!)),
              labelStyle: const TextStyle(color: Colors.white),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
              )),
        ),
      ),
    );
  }
}
