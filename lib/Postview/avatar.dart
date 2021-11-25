import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vnnews/Service/cloudfirestore.dart';

class UserAvatar extends StatelessWidget {
  final String uid;
  const UserAvatar({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CloudFireStore().getUserAvatarPath(uid),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          if (snapshot.data!.docs[0]["image"] != null) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          snapshot.data!.docs[0]["image"].toString()),
                      fit: BoxFit.cover)),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                      image: AssetImage("assets/image/images_gender_male.png"),
                      fit: BoxFit.cover)),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
