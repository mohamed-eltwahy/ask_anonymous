import 'package:ask_anonymous/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts.dart';
import '../ask_screen.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                hintText: 'كلمه المرور الجديدة',
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(
              height: 10,
            ),
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
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: OutlinedButton(
                onPressed: () {
                  Get.offAll(HomePage());
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
          ],
        ),
      ),
    );
  }
}
