import 'package:flutter/material.dart';
import 'package:vnnews/Service/authencation.dart';
import 'package:vnnews/compoment/constrant.dart';

class ProfileUsername extends StatelessWidget {
  final AuthencationService authencationService;
  const ProfileUsername({Key? key, required this.authencationService})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final username = authencationService.getCurrentUserName();
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: FutureBuilder(
        future: username,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Center(
                child: Text(
                  snapshot.data.toString(),
                  style: const TextStyle(
                      color: kDarkRed,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                  softWrap: true,
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "Người dùng",
                  style: TextStyle(
                      color: kDarkRed,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
          } else {
            return const Center(child: Text("Đang tải......"));
          }
        },
      ),
    );
  }
}
