import 'package:flutter/material.dart';

class GalleryDetail extends StatefulWidget {
  var photo;
  GalleryDetail({Key? key, this.photo}) : super(key: key);

  @override
  _GalleryDetailState createState() => _GalleryDetailState();
}

class _GalleryDetailState extends State<GalleryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Image.network(
            widget.photo['photo'],
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Text("Paylaşan: " + widget.photo['username']),
          Text("Açıklama" + widget.photo['desc'])
        ],
      ),
    );
  }
}
