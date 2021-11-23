import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vnnews/Login/login_sreen.dart';
import 'package:vnnews/SignUp/signup.dart';
import 'package:vnnews/compoment/constrant.dart';
import 'package:vnnews/compoment/roundedbutton.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            SizedBox(
              height: size.height * 0.1,
            ),
            const Text(
              "BÁO MỚI MỖI NGÀY VNNEWS",
              style: TextStyle(
                color: kDarkRed,
                fontWeight: FontWeight.bold,
                fontFamily: "Anton",
                fontSize: kDefaultFontSize + 4,
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            SvgPicture.asset(
              "assets/image/welcome_back.svg",
              height: size.height * 0.4,
            ),
            RoundedButton(
              onPress: () {
                Navigator.push<dynamic>(
                    context,
                    PageTransition<dynamic>(
                        child: const Login(),
                        duration: const Duration(milliseconds: 1500),
                        reverseDuration: const Duration(milliseconds: 1500),
                        type: PageTransitionType.scale,
                        alignment: Alignment.topRight));
              },
              text: "ĐĂNG NHẬP",
            ),
            RoundedButton(
              onPress: () {
                Navigator.push<dynamic>(
                    context,
                    PageTransition<dynamic>(
                        // ignore: prefer_const_constructors
                        child: SignUp(),
                        duration: const Duration(milliseconds: 1500),
                        reverseDuration: const Duration(milliseconds: 1500),
                        type: PageTransitionType.scale,
                        alignment: Alignment.topRight));
              },
              text: "ĐĂNG KÝ",
            )
          ],
        ),
      ),
    );
  }
}
