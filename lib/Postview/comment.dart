import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:vnnews/Postview/avatar.dart';
import 'package:vnnews/Service/cloudfirestore.dart';
import 'package:vnnews/compoment/constrant.dart';

import 'buildusername.dart';

class CreateComment extends StatelessWidget {
  final int idPost;
  const CreateComment({Key? key, required this.idPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: StreamBuilder(
          stream: CloudFireStore().getPostWithID(idPost),
          builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.connectionState != ConnectionState.waiting) {
              if (snap.data!.docs[0]["comment"].toList().length != 0) {
                return ListView.builder(
                    itemCount: snap.data!.docs[0]["comment"].length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 2),
                        leading: CircularProfileAvatar(
                          "",
                          child: UserAvatar(
                              uid: snap.data!.docs[0]["comment"][index]["uid"]
                                  .toString()),
                          radius: 20,
                          backgroundColor: Colors.transparent,
                          borderWidth: 0,
                          elevation: 5.0,
                          foregroundColor: Colors.transparent,
                          cacheImage: true,
                          imageFit: BoxFit.cover,
                          animateFromOldImageOnUrlChange: true,
                          onTap: () {},
                        ),
                        title: BuildUsername(
                          uid: snap.data!.docs[0]["comment"][index]["uid"]
                              .toString(),
                        ),
                        subtitle: Text(
                          snap.data!.docs[0]["comment"][index]["content"]
                              .toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: kDefaultFontSize - 4),
                          textAlign: TextAlign.justify,
                          softWrap: true,
                        ),
                        trailing: Text(
                          DateFormat('hh:mm dd-MM-yyyy').format(DateTime.parse(
                              snap.data!.docs[0]["comment"][index]["timestamp"]
                                  .toDate()
                                  .toString())),
                          style: const TextStyle(
                              fontSize: kDefaultFontSize - 5,
                              fontWeight: FontWeight.bold),
                          softWrap: true,
                          textAlign: TextAlign.right,
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text(
                    "Hãy là người đầu tiên bình luận !",
                    style: TextStyle(
                        fontSize: kDefaultFontSize,
                        fontWeight: FontWeight.bold),
                  ),
                );
              }
            } else {
              return Container(
                constraints:
                    const BoxConstraints(maxHeight: 100, maxWidth: 100),
                child: const Center(
                  child: LoadingIndicator(
                      indicatorType: Indicator.ballRotate,
                      colors: [
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                        Colors.black,
                        Colors.amber,
                        Colors.orange,
                        Colors.yellow,
                      ],
                      strokeWidth: 0.4,
                      backgroundColor: Colors.transparent,
                      pathBackgroundColor: Colors.black),
                ),
              );
            }
          }),
    );
  }
}
