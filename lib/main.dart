import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vnnews/Service/authencation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VN NEWS',
      theme: ThemeData(
          fontFamily: "Quicksand",
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.white),
      home: AuthencationService.handleauthstate(),
    );
  }
}


// ===========================_================================
// =                        _ooOoo_                           =
// =                       o8888888o                          =
// =                       88" . "88                          =
// =                       (| -_- |)                          =
// =                       O\  =  /O                          =
// =                    ____/`---'\____                       =
// =                  .'  \\|     |//  `.                     =
// =                 /  \\|||  :  |||//  \                    =
// =                /  _||||| -:- |||||_  \                   =
// =                |   | \\\  -  /'| |   |                   =
// =                | \_|  `\`---'//  |_/ |                   =
// =                \  .-\__ `-. -'__/-.  /                   =
// =              ___`. .'  /--.--\  `. .'___                 =
// =           ."" '<  `.___\_<|>_/___.' _> \"".              =
// =          | | :  `- \`. ;`. _/; .'/ /  .' ; |             =
// =          \  \ `-.   \_\_`. _.'_/_/  -' _.' /             =
// ============`-.`___`-.__\ \___  /__.-'_.'_.-'===============