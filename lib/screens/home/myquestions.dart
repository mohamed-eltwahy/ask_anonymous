import 'dart:io';
import 'package:ask_anonymous/provider/home_provider/get_questions.dart';
import 'package:ask_anonymous/screens/asks/ask_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../consts.dart';

class MyQuestions extends StatefulWidget {
  @override
  _MyQuestionsState createState() => _MyQuestionsState();
}

class _MyQuestionsState extends State<MyQuestions> {
  Future<dynamic> getdata() async {
    return await Future.delayed(Duration.zero).then((value) =>
        Provider.of<GetMyQuestions>(context, listen: false)
            .getmyquestiondata());
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
      body: Consumer<GetMyQuestions>(
        builder: (BuildContext context, value, Widget? child) {
          return  value.isloadingmyquestions
                  ? Center(
                      child: CircularProgressIndicator(
                        color: maincolor,
                      ),
                    )
                  :value.getquestions!.isEmpty
              ? Center(child: Text("لا يوجد أسئلة"))
              : ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: value.getquestions!.length,
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
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(value
                                                .getquestions![index]
                                                .userImage!),
                                            radius: 20,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              value.getquestions![index]
                                                  .userName!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              value.getquestions![index].date!,
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
                                            value.getquestions![index].message!,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          value.getquestions![index].image ==
                                                  null
                                              ? SizedBox()
                                              : Image.network(value
                                                  .getquestions![index].image!)
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
