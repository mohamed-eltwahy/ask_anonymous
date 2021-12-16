import 'dart:io';

import 'package:ask_anonymous/consts.dart';
import 'package:ask_anonymous/provider/authProvider/register_loginProvider.dart';
import 'package:ask_anonymous/screens/auth/confirmcode.dart';
import 'package:ask_anonymous/screens/auth/forgetpassword.dart';
import 'package:ask_anonymous/screens/home/home_page.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../myToast.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen>
    with TickerProviderStateMixin {
  bool inlogin = true;
  String? identifier;
  Future<void> getDeviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;

        setState(() {
          identifier = build.androidId;
        });
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          identifier = data.identifierForVendor;
        });
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  @override
  void initState() {
    getDeviceDetails();
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirmpassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/appicon.png',
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: devicesize.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (inlogin) {
                          } else {
                            setState(() {
                              inlogin = true;
                            });
                          }
                        },
                        child: Text(
                          'تسجيل دخول',
                          style: TextStyle(
                              color: inlogin ? maincolor : Colors.white,
                              fontSize: 15),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!inlogin) {
                          } else {
                            setState(() {
                              inlogin = false;
                              _email.clear();
                              _password.clear();
                              _confirmpassword.clear();
                              _name.clear();
                            });
                          }
                        },
                        child: Text(
                          'انشاء حساب جديد',
                          style: TextStyle(
                              color:
                                  inlogin == false ? maincolor : Colors.white,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        if (!inlogin)
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _name,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return 'الاسم مطلوب';
                              }
                            },
                            // controller: _question,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              // prefixIcon:
                              //     ImageIcon(AssetImage('assets/icons/question (7).png')),
                              border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(20.0),
                                  ),
                                  borderSide: new BorderSide(
                                    color: Colors.red,
                                  )),
                              fillColor: Colors.grey[200],
                              filled: true,

                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: maincolor),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              hintText: 'الاسم',
                              alignLabelWithHint: true,
                            ),
                          ),
                        SizedBox(
                          height: 10,
                        ),

                        TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _email,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return 'برجاء ادخال البريد الإلكتروني';
                            }
                            if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(_email.text)) {
                              return 'البريد الإلكتروني غير صالح';
                            }
                          },
                          // controller: _question,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          decoration: InputDecoration(
                            // prefixIcon:
                            //     ImageIcon(AssetImage('assets/icons/question (7).png')),
                            border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                                borderSide: new BorderSide(
                                  color: Colors.red,
                                )),
                            fillColor: Colors.grey[200],
                            filled: true,

                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: maincolor),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            hintText: 'البريد الالكتروني',
                            alignLabelWithHint: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // if (inlogin)
                        TextFormField(
                          controller: _password,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value.toString().isEmpty) {
                              return "برجاء ادخال كلمة المرور الخاص بك";
                            } else if (value.toString().length < 7) {
                              return 'كلمه المرور يجب الا تقل عن 7 احرف او ارقام';
                            }
                          },
                          obscureText: true,
                          // controller: _question,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          decoration: InputDecoration(
                            // prefixIcon:
                            //     ImageIcon(AssetImage('assets/icons/question (7).png')),
                            border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                                borderSide: new BorderSide(
                                  color: Colors.red,
                                )),
                            fillColor: Colors.grey[200],
                            filled: true,

                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: maincolor),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            hintText: 'كلمه المرور',
                            alignLabelWithHint: true,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        if (!inlogin)
                          TextFormField(
                            controller: _confirmpassword,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value.toString().isEmpty)
                                return 'برجاء ادخال تاكيد كلمه المرور';
                              if (_password.text
                                      .trim()
                                      .contains(_confirmpassword.text.trim()) ==
                                  false) return 'كلمه المرور غير مطابقه !';
                              return null;
                            },
                            obscureText: true,
                            // controller: _question,
                            keyboardType: TextInputType.text,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              // prefixIcon:
                              //     ImageIcon(AssetImage('assets/icons/question (7).png')),
                              border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(20.0),
                                  ),
                                  borderSide: new BorderSide(
                                    color: Colors.red,
                                  )),
                              fillColor: Colors.grey[200],
                              filled: true,

                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: maincolor),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              hintText: 'تاكيد كلمه المرور',
                              alignLabelWithHint: true,
                            ),
                          ),
                        if (inlogin)
                          Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(ForgetPassword());
                                },
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'نسيت كلمه المرور؟',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              )
                            ],
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: Consumer<Auth>(
                            builder: (context, value, child) {
                              return value.isloadingregister ||
                                      value.isloadinglogin
                                  ? CupertinoActivityIndicator(
                                      radius: 15.0,
                                    )
                                  : OutlinedButton(
                                      onPressed: () async {
                                         SharedPreferences pref = await SharedPreferences.getInstance();
                                        if (_formkey.currentState!.validate()) {
                                          FocusScope.of(context).unfocus();
                                          if (!inlogin) {
                                            value
                                                .register(
                                              name: _name.text,
                                              email: _email.text,
                                              password: _password.text,
                                              confirm: _confirmpassword.text,
                                              deviceId: identifier,
                                            )
                                                .then((value) {
                                              if (value['status'] == true) {
                                                showMyToast(context,
                                                    value['message'], 'sucess');
                                                Get.offAll(ConfirmCode(
                                                  pref:pref,
                                                  type: 'conf',
                                                  email: _email.text,
                                                  fromauth: true,
                                                ));
                                              } else {
                                                showMyToast(context,
                                                    value['message'], 'error');
                                              }
                                            });
                                          } else {
                                            value
                                                .login(
                                              email: _email.text,
                                              password: _password.text,
                                              deviceId: identifier,
                                            )
                                                .then((value) {
                                              if (value['status'] == true) {
                                                showMyToast(context,
                                                    value['message'], 'sucess');
                                                Get.offAll(HomePage(pref: pref,));
                                              } else {
                                                if (value['data']['data'] ==
                                                        "unactive"
                                                    // 'برجاء تفعيل الحساب اولا '
                                                    ) {
                                                  showMyToast(
                                                      context,
                                                      value['message'],
                                                      'error');
                                                  Get.offAll(ConfirmCode(
                                                    type: 'conf',
                                                    email: _email.text,
                                                    fromauth: true,
                                                  ));
                                                } else {
                                                  showMyToast(
                                                      context,
                                                      value['message'],
                                                      'error');
                                                }
                                              }
                                            });
                                          }
                                        }
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        30.0))),
                                      ),
                                      child: const Text(
                                        'دخول',
                                        style: TextStyle(color: maincolor),
                                      ),
                                    );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
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
