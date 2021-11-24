import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vnnews/Homepage/home_screen.dart';
import 'package:vnnews/Service/cloudfirestore.dart';
import 'package:vnnews/Settingpage/setting_screen.dart';
import 'package:vnnews/Videopage/video_sreen.dart';
import 'package:vnnews/compoment/constrant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  bool isSearch = false;
  final TextEditingController textEditingController = TextEditingController();
  final PageController pageController = PageController();
  Stream<QuerySnapshot> stream = CloudFireStore().getPost();
  void ontap(int index) {
    setState(() {
      isSearch = false;
      selectedIndex = index;
    });
  }

  void onSearch() {
    if (textEditingController.text.isNotEmpty) {
      setState(() {
        stream = CloudFireStore().getPostWithTittle(textEditingController.text);
      });
    } else {
      setState(() {
        stream = CloudFireStore().getPost();
      });
    }
  }

  void back() {
    setState(() {
      isSearch = false;
      textEditingController.clear();
      stream = CloudFireStore().getPost();
    });
  }

  void openSearchbar() {
    setState(() {
      isSearch = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> listPage = <Widget>[
      HomePageScreen(
        stream: stream,
      ),
      const VideoPage(),
      const SettingPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: isSearch && selectedIndex == 0
            ? IconButton(
                onPressed: back,
                icon: const Icon(
                  Icons.arrow_back,
                  color: kDarkRed,
                ),
                iconSize: size.width * 0.1,
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SvgPicture.asset(
                  "assets/icons/news_logo.svg",
                  height: size.height * 0.05,
                ),
              ),
        title: isSearch && selectedIndex == 0
            ? TextField(
                autofocus: true,
                controller: textEditingController,
                onSubmitted: (_) => onSearch(),
                scrollPadding: const EdgeInsets.all(0),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    hintStyle: TextStyle(fontSize: 17, height: 0.65),
                    hintText: "Tìm kiếm",
                    border: UnderlineInputBorder()),
              )
            : const Center(
                child: Text(
                  "VN NEWS",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Anton",
                      color: kDarkRed,
                      fontSize: kDefaultFontSize + 10,
                      fontWeight: FontWeight.bold),
                ),
              ),
        actions: <Widget>[
          isSearch == false && selectedIndex == 0
              ? IconButton(
                  onPressed: openSearchbar,
                  icon: SvgPicture.asset(
                    "assets/icons/search-icon.svg",
                    width: size.width * 0.1,
                    color: kDarkRed,
                  ),
                )
              : Container(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [listPage.elementAt(selectedIndex)],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 5),
        child: GNav(
            rippleColor: kLightRed.withOpacity(0.8),
            hoverColor: kLightRed.withOpacity(0.7),
            haptic: true,
            tabBorderRadius: 20,
            tabActiveBorder: Border.all(color: kDarkRed, width: 1),
            tabBorder: Border.all(color: kLightRed, width: 1),
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 200),
            gap: 30,
            color: Colors.grey[800],
            activeColor: kDarkRed,
            iconSize: 30,
            tabBackgroundColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            onTabChange: (value) {
              ontap(value);
            },
            tabs: const [
              GButton(
                icon: LineIcons.home,
                text: 'Trang chủ',
              ),
              GButton(
                icon: LineIcons.video,
                text: 'Video',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Người dùng',
              )
            ]),
      ),
    );
  }
}
