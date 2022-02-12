import 'package:easy_localization/easy_localization.dart';
import 'package:fitnessapp_flutter/screens/favoritepage.dart';
import 'package:flutter/material.dart';

import '../screens/exercise/exercise.dart';
import '../screens/gallery/gallerypage.dart';
import '../screens/persons.dart';
import '../screens/settingspage.dart';

class GridList extends StatefulWidget {
  const GridList({Key? key}) : super(key: key);

  @override
  _GridListState createState() => _GridListState();
}

class _GridListState extends State<GridList> {
  final List listPage = [
    "exercises",
    "members",
    "gallery",
    "settings",
    "favorite"
  ];
  final List routingPage = [
    const Exercise(),
    const PersonsPage(),
    const GalleryPage(),
    const SettingsPage(),
    const FavoritePage()
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => routingPage[index],
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 22.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.123),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  listPage[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ).tr(),
              ),
            ));
      },
    );
  }
}
