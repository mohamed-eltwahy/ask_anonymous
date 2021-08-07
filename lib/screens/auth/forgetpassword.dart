import 'package:ask_anonymous/screens/auth/confirmcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'المحتوي مطلوب';
                  }
                },
                // controller: _question,
                keyboardType: TextInputType.emailAddress,
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
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: OutlinedButton(
                onPressed: () {
                  Get.to(ConfirmCode());
                  // if (_questionkey.currentState!.validate()) {}
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
                ),
                child: const Text(
                  'تاكيد',
                  style: TextStyle(color: maincolor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
