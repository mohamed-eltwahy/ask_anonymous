import 'package:ask_anonymous/provider/authProvider/register_loginProvider.dart';
import 'package:ask_anonymous/screens/auth/confirmcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';
import '../../myToast.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _email = new TextEditingController();

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
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
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
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
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: Consumer<Auth>(
                builder: (context, value, child) {
                  return value.isloadingresetpass
                      ? CupertinoActivityIndicator(
                          radius: 15.0,
                        )
                      : OutlinedButton(
                          onPressed: () {
                            value
                                .resetpass(
                              email: _email.text,
                            )
                                .then((value) {
                              if (value['status'] == true) {
                                showMyToast(
                                    context, value['message'], 'sucess');
                                Get.offAll(ConfirmCode(
                                  email: _email.text,
                                ));
                              } else {
                                showMyToast(context, value['message'], 'error');
                              }
                            });
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                          ),
                          child: const Text(
                            'تاكيد',
                            style: TextStyle(color: maincolor),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
