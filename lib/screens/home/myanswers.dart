import 'dart:io';
import 'package:ask_anonymous/screens/asks/ask_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../consts.dart';

class MyAnswers extends StatefulWidget {


  @override
  _MyAnswersState createState() => _MyAnswersState();
}

class _MyAnswersState extends State<MyAnswers> {
  File _image;
  final picker = ImagePicker();
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
        
          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  height: 200,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(AskScreen(
                              name: 'username',
                            )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/user.jpg"),
                                radius: 20,
                              ),
                            ),
                          ),
                          Text(
                            'username',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق.',
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

}
