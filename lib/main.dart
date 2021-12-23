import 'package:ask_anonymous/consts.dart';
import 'package:ask_anonymous/provider/authProvider/editprofile.dart';
import 'package:ask_anonymous/provider/authProvider/logout.dart';
import 'package:ask_anonymous/provider/authProvider/newpassProvider.dart';
import 'package:ask_anonymous/provider/authProvider/register_loginProvider.dart';
import 'package:ask_anonymous/provider/home_provider/ask_question.dart';
import 'package:ask_anonymous/provider/home_provider/get_questions.dart';
import 'package:ask_anonymous/provider/home_provider/get_replies.dart';
import 'package:ask_anonymous/screens/splash/splash.dart';
import 'package:ask_anonymous/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: maincolor));
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, NewPassProvider>(
          create: (ctx) => NewPassProvider(),
          update: (ctx, auth, newpass) =>
              newpass?.update(auth.initSharedPrefs()),
        ),
         ChangeNotifierProxyProvider<Auth, Logout>(
          create: (ctx) => Logout(),
          update: (ctx, auth, logout) =>
              logout!..update(auth.initSharedPrefs()),
        ),
        
        ChangeNotifierProvider(
          create: (context) => EditProvider(),
        ),
         ChangeNotifierProvider(
          create: (context) => GetMyQuestions(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetMyReplies(),
        ),
          ChangeNotifierProvider(
          create: (context) => AskQuestion(),
        ),
        
        //              child: Consumer<AskQuestion>(

        ],
      child: GetMaterialApp(
        translations: Translation(),
        locale: Locale('ar'),
        fallbackLocale: Locale('ar'),
        debugShowCheckedModeBanner: false,
        title: 'Ask Anonymous',
        theme: ThemeData(fontFamily: 'Cairo', primaryColor: maincolor),
        home: Splash(),
      ),
    );
  }
}
