// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vnnews/Postview/postview_screen.dart';
import 'package:vnnews/Service/cloudfirestore.dart';
import 'package:vnnews/compoment/constrant.dart';

class HomePageScreen extends StatefulWidget {
  Stream<QuerySnapshot> stream;
  HomePageScreen({Key? key, required this.stream}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

String? dropdownValue;

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    super.initState();
    dropdownValue = "Tất cả";
  }

  void onChange(String? value) {
    setState(() {
      dropdownValue = value;
      if (value != "Tất cả") {
        widget.stream = CloudFireStore().getPostWithCategory(dropdownValue);
      } else {
        widget.stream = CloudFireStore().getPost();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  children: [
                    const Text(
                      "Tin tức mới nhất",
                      style: TextStyle(
                          fontSize: kDefaultFontSize + 7,
                          color: kDarkRed,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      underline: Container(),
                      icon: const Icon(LineIcons.arrowDown),
                      iconDisabledColor: Colors.black,
                      iconEnabledColor: kDarkRed,
                      onChanged: (String? value) => onChange(value),
                      value: dropdownValue,
                      items: ["Tất cả", "Bóng đá", "Công nghệ", "Sức khoẻ"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: kDefaultFontSize + 3,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: widget.stream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState != ConnectionState.waiting) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1.43,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  CloudFireStore().updateView(
                                      snapshot.data!.docs[index]["id"]);

                                  Navigator.push<dynamic>(
                                      context,
                                      PageTransition<dynamic>(
                                          child: PostView(
                                            postID: snapshot.data!.docs[index]
                                                ["id"],
                                          ),
                                          duration:
                                              const Duration(milliseconds: 800),
                                          reverseDuration:
                                              const Duration(milliseconds: 800),
                                          type: PageTransitionType.bottomToTop,
                                          alignment: Alignment.bottomRight));
                                },
                                child: ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: FutureBuilder(
                                        future: CloudFireStore().getImageUrl(
                                            snapshot.data!.docs[index]
                                                ["imageUrl"]),
                                        builder: (context,
                                            AsyncSnapshot<String> snapshot) {
                                          if (snapshot.connectionState !=
                                              ConnectionState.waiting) {
                                            return CachedNetworkImage(
                                                imageUrl:
                                                    snapshot.data.toString());
                                          } else {
                                            return Container();
                                          }
                                        }),
                                  ),
                                  title: Text(
                                    snapshot.data!.docs[index]["tittle"],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: kDefaultFontSize + 4),
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                  ),
                                  minVerticalPadding: 10,
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Text(
                                      snapshot.data!.docs[index]["description"],
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: kDefaultFontSize - 2),
                                      softWrap: true,
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  trailing:
                                      const Icon(LineIcons.arrowCircleRight),
                                ),
                              );
                            }),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.all(100),
                        child: SizedBox(
                          child: Center(
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
                        ),
                      );
                    }
                  }),
            ],
          ),
        ));
  }
}
