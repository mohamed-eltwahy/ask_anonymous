import 'dart:io';

import 'package:ask_anonymous/screens/auth/editprofile.dart';
import 'package:ask_anonymous/screens/auth/register_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';

import '../../consts.dart';
import '../ask_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: Container(
          width: double.infinity,
          height: 250,
          margin: EdgeInsets.only(top: 10),
          // color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PopUpMenuWidget(),
                    IconButton(
                      icon: Icon(
                        Icons.share,
                        color: maincolor,
                      ),
                      onPressed: () {
                        final RenderBox? box =
                            context.findRenderObject() as RenderBox;
                        Share.share('https://www.google.com/',
                            subject: 'Copy Link ',
                            sharePositionOrigin:
                                box!.localToGlobal(Offset.zero) & box.size);
                      },
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => pickImage(),
                  child: Container(
                    child: CircleAvatar(
                      backgroundImage: _image == null
                          ? AssetImage("assets/images/profile.png")
                              as ImageProvider
                          : FileImage(_image!),
                      backgroundColor: Colors.white70,
                      radius: 55,
                    ),
                  ),
                ),
                Text(
                  'username',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => editalert(context),
                  child: Text(
                    'تعديل البيانات الشخصيه',
                    style: TextStyle(
                      fontSize: 15,
                      color: maincolor,
                      decorationThickness: 1,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              'الأسئلة :',
              style: TextStyle(color: maincolor),
            ),
          ),
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

  void pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}

class PopUpMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (_) => Get.offAll(LoginRegisterScreen()),
      icon: Icon(
        Icons.more_vert,
        color: maincolor,
        size: 25,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text(
            'تسجيل الخروج',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
