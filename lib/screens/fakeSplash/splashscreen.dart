import 'package:ask_anonymous/screens/auth/register_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../fakeSplash/widgets/splashitem.dart';
import 'package:get/get.dart';

class SplashScreenfake extends StatefulWidget {
  @override
  _SplashScreenfakeState createState() => _SplashScreenfakeState();
}

class _SplashScreenfakeState extends State<SplashScreenfake> {
  
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 3500), () {
      Get.offAll(LoginRegisterScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: SplashItem(
            image: 'assets/images/appicon.png',
          ))
        : Scaffold(
            body: SplashItem(
              image: 'assets/images/appicon.png',
            ),
          );
  }
}
