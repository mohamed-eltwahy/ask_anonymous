import 'dart:io';
import 'package:ask_anonymous/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AskScreen extends StatefulWidget {
  String name;
  AskScreen({required this.name});

  @override
  _AskScreenState createState() => _AskScreenState();
}

class _AskScreenState extends State<AskScreen> {
  TextEditingController _question = TextEditingController();
  final _questionkey = GlobalKey<FormState>();
   File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.name.toString(),
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _questionkey,
              child: TextFormField(
                maxLength: 1000,
                maxLines: 5,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'المحتوي مطلوب';
                  }
                },
                controller: _question,
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
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'اكتب سؤالك هنا !',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: maincolor,
                  ),
                  child: Icon(
                    Icons.mic,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => pickImage(),
                    child: (_image == null)
                        ? Container(
                            child: Icon(Icons.image, size: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: maincolor),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            height: 150,
                            width: 150,
                            child: Image.file(_image!),
                          ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: FlatButton(
                onPressed: () {
                  if (_questionkey.currentState!.validate()) {}
                },
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Color.fromRGBO(0, 160, 227, 1))),
                child: const Text(
                  "ارسال",
                  style: TextStyle(color: maincolor),
                ),
              ),
            )
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
  }}
