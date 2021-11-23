import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:vnnews/Service/authencation.dart';

class ProfileImage extends StatelessWidget {
  final AuthencationService authencationService;
  const ProfileImage({Key? key, required this.authencationService})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final path = authencationService.getCurrentUserImage();
    return FutureBuilder(
      future: path,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: NetworkImage(snapshot.data.toString()),
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
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: LoadingIndicator(
                  indicatorType: Indicator.circleStrokeSpin,
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
      },
    );
  }
}
