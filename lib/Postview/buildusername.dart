import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vnnews/Service/cloudfirestore.dart';
import 'package:vnnews/compoment/constrant.dart';

class BuildUsername extends StatelessWidget {
  final String uid;
  const BuildUsername({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: CloudFireStore().getUserName(uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState != ConnectionState.waiting) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.docs[0]["name"].toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: kDefaultFontSize),
                softWrap: true,
              );
            } else {
              return const Text(
                "Người dùng",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: kDefaultFontSize),
                softWrap: true,
              );
            }
          } else {
            return const Text(
              "Người dùng",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: kDefaultFontSize),
              softWrap: true,
            );
          }
        });
  }
}
