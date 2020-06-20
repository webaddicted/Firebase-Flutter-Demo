import 'package:flutter/material.dart';
import 'package:kotlinproject/global/constant/assets_const.dart';
import 'package:kotlinproject/global/constant/color_const.dart';
import 'package:kotlinproject/global/constant/string_const.dart';
import 'package:kotlinproject/global/utils/file_utils.dart';
import 'package:kotlinproject/view/fcm_social_login.dart';
import 'package:kotlinproject/view/onboarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  createApplicationFolder();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConst.APP_NAME,
//      debugShowCheckedModeBanner: false,
//      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        fontFamily: AssetsConst.PT_FONTss,
        accentColor: ColorConst.APP_COLOR,
        accentColorBrightness: Brightness.light,
        primarySwatch: ColorConst.APP_COLOR,
      ),
      home: OnboardingScreen(),
    );
  }
}
