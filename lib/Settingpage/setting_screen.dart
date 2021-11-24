import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vnnews/Service/authencation.dart';
import 'package:vnnews/Service/cloudfirestore.dart';
import 'package:vnnews/Settingpage/compoment/profileimage.dart';
import 'package:vnnews/Settingpage/compoment/profilename.dart';
import 'package:vnnews/compoment/constrant.dart';
import 'package:vnnews/compoment/roundedbutton.dart';
import 'package:vnnews/compoment/roundedbutton_noanimation.dart';
import 'package:vnnews/compoment/roundedinput.dart';
import 'package:vnnews/compoment/roundedpassword.dart';
import 'package:vnnews/welcome/welcome_screen.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

String username = "";
String password = "";
String repassword = "";
final authencationService = AuthencationService();

class _SettingPageState extends State<SettingPage> {
  void changeName(BuildContext context) async {
    String message = "";
    if (username.isNotEmpty) {
      await authencationService.updateUsername(username).then((_) async {
        await CloudFireStore().updateUser();
      });
      Navigator.of(context).pop();
      setState(() {});
      message = "Thay đổi thành công";
    } else {
      message = "Không được trống";
    }
    showToast(
      message,
      context: context,
      animation: StyledToastAnimation.slideFromRight,
      reverseAnimation: StyledToastAnimation.slideToRight,
      position: StyledToastPosition.top,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 3),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastOutSlowIn,
    );
  }

  void changePassword(BuildContext context) async {
    String message = "";
    if (password.isNotEmpty && password == repassword && password.length > 6) {
      await authencationService.updatePassword(password);
      Navigator.pushAndRemoveUntil<dynamic>(
          context,
          PageTransition<dynamic>(
              alignment: Alignment.center,
              child: const Welcome(),
              duration: const Duration(milliseconds: 700),
              type: PageTransitionType.leftToRightWithFade),
          (Route<dynamic> route) => false);
      message = "Thay đổi thành công, vui lòng đăng nhập lại";
    } else {
      if (password.isEmpty || repassword.isEmpty) {
        message = "Không được trống";
      }
      if (password.length < 6) {
        message = "Mật khẩu phải lớn hơn 6 ký tự";
      }
      if (password != repassword) {
        message = "Mật khẩu phải trùng nhau";
      }
    }
    showToast(
      message,
      context: context,
      animation: StyledToastAnimation.slideFromRight,
      reverseAnimation: StyledToastAnimation.slideToRight,
      position: StyledToastPosition.top,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 3),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastOutSlowIn,
    );
  }

  Future<void> getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      String url = await CloudFireStore().upLoadAvatar(pickedFile);
      authencationService.updateAvatar(url).then((value) async {
        await CloudFireStore().updateUser();
        showToast(
          "Thay đổi thành công",
          context: context,
          animation: StyledToastAnimation.slideFromRight,
          reverseAnimation: StyledToastAnimation.slideToRight,
          position: StyledToastPosition.top,
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 3),
          curve: Curves.fastLinearToSlowEaseIn,
          reverseCurve: Curves.fastOutSlowIn,
        );
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            CircularProfileAvatar(
              "",
              child: ProfileImage(
                authencationService: authencationService,
              ),
              radius: 100,
              backgroundColor: Colors.transparent,
              borderWidth: 10,
              elevation: 5.0,
              foregroundColor: Colors.black45,
              cacheImage: true,
              imageFit: BoxFit.cover,
              animateFromOldImageOnUrlChange: true,
              onTap: () {
                getFromGallery();
              },
            ),
            ProfileUsername(
              authencationService: authencationService,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => showMaterialModalBottomSheet<dynamic>(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RoundedInput(
                                icon: Icons.person,
                                hintText: "Tên người dùng",
                                onChange: (value) => {username = value}),
                            RoundedButtonNormal(
                              press: () => changeName(context),
                              text: "Thay đổi",
                              color: Colors.green,
                            ),
                            RoundedButtonNormal(
                              press: () {
                                Navigator.of(context).pop();
                              },
                              text: "Huỷ",
                              color: Colors.red,
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
                  }),
              child: const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: ListTile(
                  title: Text(
                    "Thay đổi tên người dùng",
                    style: TextStyle(
                        color: kDarkRed,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_sharp,
                    size: 28,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => showMaterialModalBottomSheet<dynamic>(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RoundedPassword(
                                hintText: "Mật khẩu",
                                onChanged: (value) => {password = value}),
                            RoundedPassword(
                                hintText: "Nhập lại mật khẩu",
                                onChanged: (value) => {repassword = value}),
                            RoundedButtonNormal(
                              press: () => changePassword(context),
                              text: "Thay đổi",
                              color: Colors.green,
                            ),
                            RoundedButtonNormal(
                              press: () {
                                Navigator.of(context).pop();
                              },
                              text: "Huỷ",
                              color: Colors.red,
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
                  }),
              child: const Padding(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: ListTile(
                  title: Text(
                    "Thay đổi mật khẩu",
                    style: TextStyle(
                        color: kDarkRed,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right_sharp,
                    size: 28,
                  ),
                ),
              ),
            ),
            const Spacer(),
            RoundedButton(
                onPress: () {
                  AuthencationService().signOut(context);
                },
                text: "ĐĂNG XUẤT")
          ],
        ),
      ),
    );
  }
}
