import 'package:ask_anonymous/consts.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

editalert(BuildContext context) {
  return showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: EditProfile(),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 800),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return null!;
      });
}

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      titlePadding: EdgeInsets.all(0),
      title: Container(
        decoration: BoxDecoration(
            color: maincolor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.0),
                topLeft: Radius.circular(12.0))),
        alignment: Alignment.center,
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(0.0),
        child: Text(
          'تعديل البيانات الشخصيه',
          style:
              TextStyle(color: Colors.white, fontFamily: "Cairo", fontSize: 16),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Column(
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
              hintText: 'الاسم',
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
              hintText: 'البريد الالكتروني',
              alignLabelWithHint: true,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            width: 200,
            child: OutlinedButton(
              onPressed: () {
                Get.back();
                // if (_questionkey.currentState!.validate()) {}
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0))),
              ),
              child: const Text(
                'تعديل',
                style: TextStyle(color: maincolor),
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}
