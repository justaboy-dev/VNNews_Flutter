import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vnnews/Login/login_sreen.dart';
import 'package:vnnews/Service/authencation.dart';
import 'package:vnnews/compoment/already_have_an_account_check.dart';
import 'package:vnnews/compoment/constrant.dart';
import 'package:vnnews/compoment/roundedbutton.dart';
import 'package:vnnews/compoment/roundedinput.dart';
import 'package:vnnews/compoment/roundedinput_novalid.dart';
import 'package:vnnews/compoment/roundedpassword.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static final signupformKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String username = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
              key: signupformKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  const Text(
                    "ĐĂNG KÝ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: kDefaultFontSize + 10,
                        color: kDarkRed,
                        fontFamily: "Anton"),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  SvgPicture.asset(
                    "assets/image/register_back.svg",
                    height: size.height * 0.3,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  RoundedInputNormal(
                      icon: Icons.person,
                      hintText: "Tên người dùng",
                      onChange: (value) {
                        username = value;
                      }),
                  RoundedInput(
                      icon: Icons.mail,
                      hintText: "Tài khoản email",
                      onChange: (value) {
                        email = value;
                      }),
                  RoundedPassword(
                    iconColors: kDarkRed,
                    hintText: "Mật khẩu",
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  RoundedButton(
                      onPress: () {
                        if (signupformKey.currentState!.validate()) {
                          AuthencationService()
                              .emailSignUp(context, email, password, username);
                        }
                      },
                      text: "ĐĂNG KÝ"),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  AlreadyHaveAnAccountCheck(
                      login: false,
                      press: () {
                        Navigator.pushReplacement<dynamic, dynamic>(
                            context,
                            PageTransition<dynamic>(
                                reverseDuration: const Duration(seconds: 1),
                                alignment: Alignment.topLeft,
                                child: const Login(),
                                duration: const Duration(seconds: 1),
                                type: PageTransitionType.scale));
                      }),
                ],
              )),
        ),
      ),
    );
  }
}
