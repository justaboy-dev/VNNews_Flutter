import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vnnews/Postview/comment.dart';
import 'package:vnnews/Postview/commenttextfield.dart';
import 'package:vnnews/Postview/createlist.dart';
import 'package:vnnews/Service/cloudfirestore.dart';
import 'package:vnnews/compoment/constrant.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key, required this.postID}) : super(key: key);
  final int postID;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: CloudFireStore().getPostWithID(widget.postID),
        builder: (context, AsyncSnapshot<QuerySnapshot> postSnapshot) {
          if (postSnapshot.connectionState != ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: kDarkRed,
                    size: MediaQuery.of(context).size.width * 0.09,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: CloudFireStore().getImageUrl(postSnapshot
                              .data!.docs[0]["imageUrl"]
                              .toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return CachedNetworkImage(
                                imageUrl: snapshot.data.toString(),
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    height: 250,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                },
                                fadeInCurve: Curves.easeInBack,
                                fadeInDuration:
                                    const Duration(milliseconds: 1500),
                                fadeOutCurve: Curves.easeOutBack,
                                fadeOutDuration:
                                    const Duration(milliseconds: 1500),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, dynamic error) {
                                  return Container(
                                    height: 200,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/image/no_image.jpg"),
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 100),
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
                      CreateList(
                        post: postSnapshot.data!.docs[0],
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.07,
                child: Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        showMaterialModalBottomSheet(
                            useRootNavigator: true,
                            enableDrag: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                margin: const EdgeInsets.all(10),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.4,
                                        ),
                                        child: CreateComment(
                                            idPost: postSnapshot.data!.docs[0]
                                                ["id"]),
                                      ),
                                      CommentTextField(
                                        snapshot: postSnapshot.data!.docs[0],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom))
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Stack(clipBehavior: Clip.none, children: [
                        Positioned(
                          top: -10,
                          right: -15,
                          child: postSnapshot.data!.docs[0]["comment"]
                                  .toList()
                                  .isNotEmpty
                              ? Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                    color: kLightRed,
                                  ),
                                  child: Text(
                                    postSnapshot.data!.docs[0]["comment"]
                                        .toList()
                                        .length
                                        .toString(),
                                    style: const TextStyle(
                                        color: kDarkRed,
                                        fontSize: kDefaultFontSize - 3,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Container(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: postSnapshot.data!.docs[0]["comment"]
                                          .toList()
                                          .length >
                                      10
                                  ? 8.0
                                  : 0),
                          child: Icon(
                            LineIcons.comment,
                            size: MediaQuery.of(context).size.width * 0.09,
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
