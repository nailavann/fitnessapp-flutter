import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/person_service.dart';

class PersonsPage extends StatefulWidget {
  const PersonsPage({Key? key}) : super(key: key);

  @override
  _PersonsPageState createState() => _PersonsPageState();
}

class _PersonsPageState extends State<PersonsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: Colors.white.withOpacity(.123),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: PersonService.viewPerson(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var person = snapshot.data!.docs[index];
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, top: 2),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 22.0),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                person['username'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
