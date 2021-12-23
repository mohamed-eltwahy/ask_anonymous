import 'package:ask_anonymous/provider/apiLinks.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../myDio.dart';

class AskQuestion with ChangeNotifier {
  bool _isloading = false;
  bool get isloading => _isloading;

  dynamic sendquestion({String? question, String? img, int? touser}) async {
  
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? apitoken = pref.getString('token');
    dynamic header = {
      'Authorization': 'Bearer $apitoken',
      // "Content-Type": "multipart/form-data"
    };
      _isloading = true;
    notifyListeners();
    // FormData askdata;
    // if (img != null) {
    //   askdata = FormData.fromMap(({
    //     "message": question,
    //     "to_user_id": touser,
    //     // "record"
    //     // "image": await MultipartFile.fromFile(img),
    //   }));
    // } else {
    //   askdata = FormData.fromMap(({
    //     "message": question,
    //     "to_user_id": touser,
    //   }));
    // }
    Map<String, dynamic> asquestionbody = await myDio(
        url: ApiLinks.baseUrl + ApiLinks.ask,
        methodType: 'post',
        appLanguage: 'ar',
        dioHeaders: header,
        dioBody: FormData.fromMap(({
          'image':"",
          "record":"",
        "message": question,
        "to_user_id": touser,
      })));
    if (asquestionbody['status'] == true) {
      _isloading = false;
      notifyListeners();
      return asquestionbody;
    } else {
      _isloading = false;
      notifyListeners();
      return asquestionbody;
    }
  }
}
