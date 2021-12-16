import 'dart:io';
import 'package:ask_anonymous/provider/authProvider/logout.dart';
import 'package:ask_anonymous/screens/auth/editprofile.dart';
import 'package:ask_anonymous/screens/auth/register_login.dart';
import 'package:ask_anonymous/screens/home/myanswers.dart';
import 'package:ask_anonymous/screens/home/myquestions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../consts.dart';
import '../../myToast.dart';

class HomePage extends StatefulWidget {
  SharedPreferences? pref;

  HomePage({this.pref});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  File? _image;
  final picker = ImagePicker();
  TabController? _tabController;
  @override
  String? name;
  void initState() {
    setState(() {
      name = widget.pref?.getString('name').toString();
    });
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

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
                        String? url = widget.pref?.getString('link');
                        print('urllllll' + url!);
                        final RenderBox box =
                            context.findRenderObject() as RenderBox;
                        Share.share('$url',
                            subject: 'Copy Link ',
                            sharePositionOrigin:
                                box.localToGlobal(Offset.zero) & box.size);
                      },
                    ),
                  ],
                ),
                if (_image != null)
                  Container(
                    height: 90,
                    // width: 80,
                    //     color: Colors.red,
                    child: InkWell(
                      onTap: () => pickImage(),
                      child: CircleAvatar(
                        backgroundImage: FileImage(
                          _image!,
                        ),
                        maxRadius: 55,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  )
                else
                  Container(
                    height: 90,
                    //width: 80,
                    child: InkWell(
                      onTap: () => pickImage(),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: CachedNetworkImageProvider(
                            widget.pref!.getString('image')!),
                      ),
                    ),
                  ),
                Text(
                  name!,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () => editalert(context, widget.pref!),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // give the tab bar a height [can change hheight to preferred height]
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: maincolor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'الأسئلة',
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'الردود',
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  MyAnswers(),

                  // second tab bar view widget
                  MyQuestions()
                ],
              ),
            ),
          ],
        ),
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
    return Container(
      margin: EdgeInsets.all(10),
      child: Consumer<Logout>(builder: (context, value, child) {
        return RaisedButton.icon(
          onPressed: () async {
            Get.back();
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return Center(
                      child: Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: maincolor,
                      ),
                    ),
                  ));
                });
            await value.logout().then((value) {
              if (value['status'] == true) {
                Get.offAll(LoginRegisterScreen());
                showMyToast(context, value['message'], 'success');
              } else {
                showMyToast(context, value['message'], 'error');
              }
            });
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          label: Text(
            'تسجيل الخروج',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          textColor: Colors.white,
          splashColor: Colors.grey[400],
          color: maincolor,
        );
      }),
    );
  }
}
