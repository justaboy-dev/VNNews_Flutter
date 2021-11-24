import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vnnews/MainSreen/main_sreen.dart';
import 'package:vnnews/Service/cloudfirestore.dart';
import 'package:vnnews/welcome/welcome_screen.dart';

class AuthencationService with ChangeNotifier {
  final auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late GoogleSignIn googleUser;

  static Widget handleauthstate() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const MainScreen();
          } else {
            return const Welcome();
          }
        });
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: <String>[
      "email",
      'https://www.googleapis.com/auth/userinfo.profile',
    ]).signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential user = await auth.signInWithCredential(credential);
    if (user.additionalUserInfo!.isNewUser) {
      await CloudFireStore().createUser();
    }
    showToast(
      'Đăng nhập thành công',
      context: context,
      animation: StyledToastAnimation.slideFromRight,
      reverseAnimation: StyledToastAnimation.slideToRight,
      position: StyledToastPosition.top,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 3),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastOutSlowIn,
    );
    Navigator.pushAndRemoveUntil<dynamic>(
        context,
        PageTransition<dynamic>(
            child: const MainScreen(),
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 1500),
            type: PageTransitionType.size),
        (Route<dynamic> route) => false);
  }

  Future<User?> getSignInAccount() async {
    return auth.currentUser;
  }

  Future<String?> getCurrentUserEmail() async {
    return auth.currentUser!.email;
  }

  Future<String?> getCurrentUserImage() async {
    return auth.currentUser!.photoURL;
  }

  Future<String?> getCurrentUserID() async {
    return auth.currentUser!.uid;
  }

  Future<String?> getCurrentUserName() async {
    return auth.currentUser!.displayName;
  }

  Future<void> updateUsername(String value) async {
    await auth.currentUser!.updateDisplayName(value);
  }

  Future<void> updatePassword(String value) async {
    await auth.currentUser!.updatePassword(value);
  }

  Future<void> updateAvatar(String src) async {
    await auth.currentUser!.updatePhotoURL(src);
  }

  Future<void> emailSignIn(
      BuildContext context, String username, String password) async {
    String message = "";
    try {
      await auth.signInWithEmailAndPassword(
          email: username, password: password);
      message = "Đăng nhập thành công";
      Navigator.pushAndRemoveUntil<dynamic>(
          context,
          PageTransition<dynamic>(
              child: const MainScreen(),
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 1500),
              type: PageTransitionType.size),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = "Tài khoản không tồn tại";
      } else if (e.code == 'wrong-password') {
        message = "Sai mật khẩu";
      }
    } catch (ex) {
      // ignore: avoid_print
      print(ex);
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

  Future<void> emailSignUp(BuildContext context, String email, String password,
      String username) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emailSignIn(context, email, password).then((value) async {
        updateUsername(username);
        CloudFireStore().createUser();
      });
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "email-already-in-use") {
        showToast(
          'Email đã được sử dụng',
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
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> signOut(BuildContext context) async {
    googleUser = GoogleSignIn(scopes: <String>["email"]);
    await auth.signOut();
    googleUser.signOut();
    showToast(
      'Đăng xuất thành công',
      context: context,
      animation: StyledToastAnimation.slideFromRight,
      reverseAnimation: StyledToastAnimation.slideToRight,
      position: StyledToastPosition.top,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 3),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastOutSlowIn,
    );
    Navigator.pushAndRemoveUntil<dynamic>(
        context,
        PageTransition<dynamic>(
            alignment: Alignment.center,
            child: const Welcome(),
            duration: const Duration(milliseconds: 1500),
            type: PageTransitionType.leftToRightWithFade),
        (Route<dynamic> route) => false);
  }
}
