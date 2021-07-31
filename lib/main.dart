import 'package:ask_anonymous/consts.dart';
import 'package:ask_anonymous/screens/fakeSplash/splashscreen.dart';
import 'package:ask_anonymous/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: maincolor));
    return GetMaterialApp(
      translations: Translation(),
      locale: Locale('ar'),
      fallbackLocale: Locale('ar'),
      debugShowCheckedModeBanner: false,
      title: 'Ask Anonymous',
      theme: ThemeData(fontFamily: 'Cairo', primaryColor: maincolor),
      home: SplashScreenfake(),
    );
  }
}
