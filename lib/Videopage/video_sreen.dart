import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:vnnews/Service/cloudfirestore.dart';
import 'package:vnnews/Videopage/compoment/video_player.dart';
import 'package:vnnews/compoment/constrant.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  void shareTap(Future<String> path) async {
    String value = await path;
    FlutterWebBrowser.openWebPage(
      url: "https://www.facebook.com/sharer/sharer.php?u=" + value,
      customTabsOptions: const CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        toolbarColor: Colors.deepPurple,
        secondaryToolbarColor: Colors.green,
        navigationBarColor: Colors.amber,
        addDefaultShareMenuItem: true,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: const SafariViewControllerOptions(
        barCollapsingEnabled: true,
        preferredBarTintColor: Colors.green,
        preferredControlTintColor: Colors.amber,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Text(
                  "Video nổi bật",
                  style: TextStyle(
                      fontSize: kDefaultFontSize + 7,
                      color: kDarkRed,
                      fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder(
                  stream: CloudFireStore().getVideo(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState != ConnectionState.waiting) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height / 1.38,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  height: 320,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Wrap(
                                    children: [
                                      FutureBuilder(
                                          future: CloudFireStore().getVideoUrl(
                                              snapshot.data!.docs[index]
                                                  ["videoUrl"]),
                                          builder: (context,
                                              AsyncSnapshot<String>
                                                  futuresnapshot) {
                                            if (futuresnapshot
                                                    .connectionState !=
                                                ConnectionState.waiting) {
                                              return SingleVideoPlayer(
                                                  videoSrc: futuresnapshot.data
                                                      .toString());
                                            } else {
                                              return Container();
                                            }
                                          }),
                                      Text(
                                        snapshot.data!.docs[index]["tittle"],
                                        style: const TextStyle(
                                            fontSize: kDefaultFontSize + 5,
                                            fontWeight: FontWeight.bold),
                                        softWrap: true,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Icon(
                                                LineIcons.clock,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                              ),
                                            ),
                                            Text(
                                              DateFormat('dd-MM-yyyy hh:mm')
                                                  .format(DateTime.parse(
                                                      snapshot
                                                          .data!
                                                          .docs[index]
                                                              ["posttime"]
                                                          .toDate()
                                                          .toString())),
                                              style: const TextStyle(
                                                  fontSize: kDefaultFontSize,
                                                  fontWeight: FontWeight.bold),
                                              softWrap: true,
                                            ),
                                            IconButton(
                                                onPressed: () => shareTap(
                                                    CloudFireStore()
                                                        .getVideoUrl(snapshot
                                                                .data!
                                                                .docs[index]
                                                            ["videoUrl"])),
                                                icon: Icon(
                                                  LineIcons.share,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.07,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Center(
                        child: Container(
                          constraints: const BoxConstraints(
                              maxHeight: 100, maxWidth: 100),
                          child: const LoadingIndicator(
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
                  })
            ],
          ),
        ));
  }
}
