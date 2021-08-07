import 'package:ask_anonymous/consts.dart';
import 'package:ask_anonymous/screens/auth/confirmcode.dart';
import 'package:ask_anonymous/screens/auth/forgetpassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen>
    with TickerProviderStateMixin {
  bool inlogin = true;
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
                          color: inlogin == false ? maincolor : Colors.white,
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
                    TextFormField(
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'المحتوي مطلوب';
                        }
                      },
                      // controller: _question,
                      keyboardType: TextInputType.multiline,
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
                    if (!inlogin)
                      TextFormField(
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'المحتوي مطلوب';
                          }
                        },
                        // controller: _question,
                        keyboardType: TextInputType.multiline,
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
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return 'المحتوي مطلوب';
                        }
                      },
                      // controller: _question,
                      keyboardType: TextInputType.multiline,
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
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return 'المحتوي مطلوب';
                          }
                        },
                        // controller: _question,
                        keyboardType: TextInputType.multiline,
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
                      child: OutlinedButton(
                        onPressed: () {
                          Get.offAll(ConfirmCode(
                            fromauth: true,
                          ));
                          // if (_questionkey.currentState!.validate()) {}
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0))),
                        ),
                        child: const Text(
                          'دخول',
                          style: TextStyle(color: maincolor),
                        ),
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
    );
  }
}
