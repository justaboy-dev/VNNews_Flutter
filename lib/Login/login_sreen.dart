import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vnnews/Service/authencation.dart';
import 'package:vnnews/SignUp/signup.dart';
import 'package:vnnews/compoment/already_have_an_account_check.dart';
import 'package:vnnews/compoment/constrant.dart';
import 'package:vnnews/compoment/or_divider.dart';
import 'package:vnnews/compoment/roundedbutton.dart';
import 'package:vnnews/compoment/roundedinput.dart';
import 'package:vnnews/compoment/roundedpassword.dart';
import 'package:vnnews/compoment/socialicon.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
              key: formKey,
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
                    "ĐĂNG NHẬP",
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
                    "assets/image/login_back.svg",
                    height: size.height * 0.3,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  RoundedInput(
                      icon: Icons.mail,
                      hintText: "Tài khoản email",
                      onChange: (value) {
                        email = value;
                      }),
                  RoundedPassword(
                    hintText: "Mật khẩu",
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  RoundedButton(
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          AuthencationService()
                              .emailSignIn(context, email, password);
                        }
                      },
                      text: "ĐĂNG NHẬP"),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  AlreadyHaveAnAccountCheck(press: () {
                    Navigator.pushReplacement<dynamic, dynamic>(
                        context,
                        PageTransition<dynamic>(
                            reverseDuration: const Duration(seconds: 1),
                            alignment: Alignment.topLeft,
                            child: const SignUp(),
                            duration: const Duration(seconds: 1),
                            type: PageTransitionType.scale));
                  }),
                  const OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIcon(
                          iconSrc: "assets/icons/icon_google.svg",
                          press: () {
                            AuthencationService().signInWithGoogle(context);
                          })
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
