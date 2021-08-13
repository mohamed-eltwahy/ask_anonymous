import 'package:ask_anonymous/provider/authProvider/newpassProvider.dart';
import 'package:ask_anonymous/provider/authProvider/register_loginProvider.dart';
import 'package:ask_anonymous/screens/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';
import '../../myToast.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController _password = new TextEditingController();
  TextEditingController _confirmpassword = new TextEditingController();
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                keyboardType: TextInputType.text,
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
                  hintText: 'كلمه المرور الجديدة',
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                keyboardType: TextInputType.text,
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
                  hintText: 'تاكيد كلمه المرور',
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: Consumer<NewPassProvider>(
                  builder: (context, value, child) {
                    return value.isloadingnewpass
                        ? CupertinoActivityIndicator(
                            radius: 15.0,
                          )
                        : OutlinedButton(
                            onPressed: () {
                              value
                                  .newpass(
                                newpassword: _password.text,
                                confirmpass: _confirmpassword.text,
                              )
                                  .then((value) {
                                if (value['status'] == true) {
                                  showMyToast(
                                      context, value['message'], 'sucess');
                                  Get.offAll(HomePage());
                                } else {
                                  showMyToast(
                                      context, value['message'], 'error');
                                }
                              });
                            },
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
            ],
          ),
        ),
      ),
    );
  }
}
