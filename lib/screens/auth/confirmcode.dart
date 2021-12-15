import 'dart:async';

import 'package:ask_anonymous/provider/authProvider/register_loginProvider.dart';
import 'package:ask_anonymous/screens/auth/newpass.dart';
import 'package:ask_anonymous/screens/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts.dart';
import '../../myToast.dart';

class ConfirmCode extends StatefulWidget {
  bool fromauth;
  String email;
  String type;
  SharedPreferences pref;
  ConfirmCode({this.fromauth, this.email, this.type,this.pref});

  @override
  _ConfirmCodeState createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  StreamController<ErrorAnimationType> errorController;
  TextEditingController _pin;
  bool haserror = false;
  bool view = false;
  @override
  void initState() {
    print('emaillll ' + widget.email.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'), fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
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
                            onCompleted: (code) async {
                              await Provider.of<Auth>(context, listen: false)
                                  .verify(
                                code: code,
                                email: widget.email,
                              )
                                  .then((value) {
                                if (value['status'] == true) {
                                  showMyToast(
                                      context, value['message'], 'sucess');
                                  widget.type == 'conf'
                                      ? Get.offAll(HomePage(pref: widget.pref,))
                                      : Get.offAll(NewPassword());
                                } else {
                                  showMyToast(
                                      context, value['message'], 'error');
                                }
                              });
                            },
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
                        child: Consumer<Auth>(
                          builder: (context, value, child) {
                            return value.isloadingverify
                                ? CupertinoActivityIndicator(
                                    radius: 15.0,
                                  )
                                : OutlinedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0))),
                                    ),
                                    child: const Text(
                                      "إرسال",
                                      style: TextStyle(color: maincolor),
                                    ),
                                  );
                          },
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Center(
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Text(
                      //         'لم يتم إرسال الكود؟',
                      //         style: TextStyle(fontSize: 16),
                      //       ),
                      //       SizedBox(
                      //         width: 10,
                      //       ),
                      //       Consumer<Auth>(
                      //         builder: (context, value, child) {
                      //           return value.isloadingverify
                      //               ? CupertinoActivityIndicator(
                      //                   radius: 15.0,
                      //                 )
                      //               : GestureDetector(
                      //                   onTap: () {},
                      //                   child: Text(
                      //                     'إعادة إرسال',
                      //                     style: TextStyle(
                      //                       fontSize: 15,
                      //                       color: maincolor,
                      //                       decorationThickness: 1,
                      //                       decoration: TextDecoration.underline,
                      //                       decorationStyle:
                      //                           TextDecorationStyle.solid,
                      //                     ),
                      //                   ),
                      //                 );
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
