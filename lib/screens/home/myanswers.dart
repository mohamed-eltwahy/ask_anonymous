import 'dart:io';
import 'package:ask_anonymous/provider/home_provider/get_replies.dart';
import 'package:ask_anonymous/screens/asks/ask_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../consts.dart';

class MyAnswers extends StatefulWidget {
  @override
  _MyAnswersState createState() => _MyAnswersState();
}

class _MyAnswersState extends State<MyAnswers> {
  Future<dynamic> getdata() async {
    return await Future.delayed(Duration.zero).then((value) =>
        Provider.of<GetMyReplies>(context, listen: false).getmyrepliesdata());
  }

  File? _image;
  final picker = ImagePicker();
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GetMyReplies>(
        builder: (BuildContext context, value, Widget? child) {
          return  value.isloadingreplies
                  ? Center(
                      child: CircularProgressIndicator(
                        color: maincolor,
                      ),
                    )
                  :value.getmyreplies!.isEmpty
              ? Center(child: Text("لا يوجد ردود"))
              : ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: value.getmyreplies!.length,
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
                                            name: value
                                                .getmyreplies![index].userName!,
                                          )),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  value.getmyreplies![index]
                                                      .userImage!),
                                              radius: 20,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.getmyreplies![index]
                                                  .userName!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              value.getmyreplies![index].date!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: Column(
                                        children: [
                                          Text(
                                            value.getmyreplies![index].message!,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          value.getmyreplies![index].image ==
                                                  null
                                              ? SizedBox()
                                              : Image.network(value
                                                  .getmyreplies![index].image!)
                                        ],
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
                    );
        },
      ),
    );
  }
}
