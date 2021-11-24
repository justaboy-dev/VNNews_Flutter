import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:vnnews/Postview/avatar.dart';
import 'package:vnnews/compoment/constrant.dart';

class CreateComment extends StatelessWidget {
  final List<dynamic> comment;
  const CreateComment({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: ListView.builder(
          itemCount: comment.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 5),
              leading: CircularProfileAvatar(
                "",
                child: UserAvatar(uid: comment[index]["uid"].toString()),
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
              title: Text(
                comment[index]["content"].toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: kDefaultFontSize),
                softWrap: true,
              ),
              subtitle: Text(
                comment[index]["content"].toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: kDefaultFontSize),
                softWrap: true,
              ),
            );
          }),
    );
  }
}
