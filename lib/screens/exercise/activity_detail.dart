import 'package:carousel_slider/carousel_slider.dart';
import 'package:fitnessapp_flutter/const/hive_const.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ActivityDetail extends StatefulWidget {
  var bodyListDetail;
  int index;
  ActivityDetail({Key? key, required this.bodyListDetail, required this.index})
      : super(key: key);

  @override
  _ActivityDetailState createState() =>
      _ActivityDetailState(bodyListDetail, index);
}

class _ActivityDetailState extends State<ActivityDetail> {
  var bodyListDetail;
  int index;
  _ActivityDetailState(this.bodyListDetail, this.index);
  Box box = Hive.box(HiveConst.FAVORITE_BOX);
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    debugPrint(box.toMap().toString());
    return Scaffold(
        backgroundColor: const Color(0xffbdc3c7),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            ValueListenableBuilder<Box>(
                valueListenable: box.listenable(),
                builder: (context, value, child) {
                  return IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                        isFavorite
                            ? box.put(
                                bodyListDetail.hareketAdi.toString().length,
                                bodyListDetail.hareketAdi)
                            : box.delete(
                                bodyListDetail.hareketAdi.toString().length);
                      },
                      icon: Icon(Icons.favorite,
                          color:
                              isFavorite != false ? Colors.white : Colors.red));
                })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider.builder(
                itemCount: bodyListDetail.foto.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = bodyListDetail.foto[index];
                  return Image.asset(urlImage, fit: BoxFit.cover);
                },
                options: CarouselOptions(
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlay: true,
                  viewportFraction: 1,
                  height: 350,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 22.0),
                decoration: BoxDecoration(
                  color: const Color(0xff7f8c8d),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  bodyListDetail.hareketAdi,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                decoration: BoxDecoration(
                  color: const Color(0xff7f8c8d),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 3,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  bodyListDetail.teknik,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
