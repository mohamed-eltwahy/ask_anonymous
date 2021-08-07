import 'dart:async';

import 'package:ask_anonymous/screens/auth/newpass.dart';
import 'package:ask_anonymous/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../consts.dart';
import '../ask_screen.dart';

class ConfirmCode extends StatefulWidget {
  bool? fromauth;
  ConfirmCode({this.fromauth});

  @override
  _ConfirmCodeState createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  StreamController<ErrorAnimationType>? errorController;
  TextEditingController? _pin;
  bool haserror = false;
  bool view = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'كود التفعيل',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'من فضلك أدخل الكود للتفعيل',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: PinCodeTextField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        autoDismissKeyboard: true,
                        backgroundColor: Colors.transparent,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          inactiveColor: Color.fromRGBO(220, 217, 217, 1),
                          activeColor: maincolor,
                          selectedColor: Colors.white30,
                          selectedFillColor: Colors.grey,
                          inactiveFillColor: Colors.white,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeFillColor:
                              haserror ? Colors.redAccent : Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: _pin,
                        onCompleted: (code) async {},
                        onChanged: (value) {
                          setState(() {
                            haserror = false;
                          });
                          // print(value);
                        },
                        appContext: context,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: OutlinedButton(
                      onPressed: () {
                        widget.fromauth == true
                            ? Get.offAll(HomePage())
                            : Get.offAll(NewPassword());
                        // if (_questionkey.currentState!.validate()) {}
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                      ),
                      child: const Text(
                        "إرسال",
                        style: TextStyle(color: maincolor),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'لم يتم إرسال الكود؟',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'إعادة إرسال',
                          style: TextStyle(
                            fontSize: 15,
                            color: maincolor,
                            decorationThickness: 1,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
