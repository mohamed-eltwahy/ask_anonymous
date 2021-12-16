import 'dart:async';
import 'package:ask_anonymous/consts.dart';
import 'package:ask_anonymous/screens/auth/register_login.dart';
import 'package:ask_anonymous/screens/home/home_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
   AnimationController? _animationController;
   Animation<double>? _fadeAnimation;
   Animation<Offset>? _translateAnimation;
  Future<void> navigatToNextScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('isLogin') == true) {
      Get.offAll(HomePage(pref: pref,));
    } else {
      Get.offAll(LoginRegisterScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeInOutCubic,
      ),
    );
    _translateAnimation = Tween<Offset>(
      begin: Offset(0, 55),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeOutCubic,
    ));
    _animationController!.forward();

    Future.delayed(Duration.zero, () async {});

    Timer(Duration(seconds: 3), () async {
      navigatToNextScreen();
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (cxt, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController!,
                  builder: (cxt, child) => FadeTransition(
                    opacity: _fadeAnimation!,
                    child: Transform.translate(
                      offset: _translateAnimation!.value,
                      child: child,
                    ),
                  ),
                  child: Container(
                    width: 150,
                    height: 200, //
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/appicon.png',
                          fit: BoxFit.contain,
                        ),
                        Text(
                          'Ask Anonymous',
                          style: TextStyle(fontSize: 22, color: maincolor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
