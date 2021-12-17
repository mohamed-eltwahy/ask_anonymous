import 'package:ask_anonymous/model/messages.dart';
import 'package:ask_anonymous/provider/apiLinks.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../myDio.dart';

class GetMyQuestions with ChangeNotifier {
  bool isloadingmyquestions = false;
  List<Messages>? getquestions;
  Future<dynamic> getmyquestiondata() async {
    isloadingmyquestions = true;
    getquestions = [];
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? apitoken = pref.getString('token');
    dynamic header = {'Authorization': 'Bearer $apitoken'};
    Map<dynamic, dynamic> getPriceFilterSearch = await myDio(
        url: ApiLinks.baseUrl + ApiLinks.myquestions,
        methodType: 'get',
        appLanguage: 'ar',
        dioHeaders: header);
    print('questions ' + getPriceFilterSearch.toString());
    if (getPriceFilterSearch['status'] == true) {
      isloadingmyquestions = false;

      notifyListeners();
      getquestions = (getPriceFilterSearch['data'] as List)
          .map((e) => Messages.fromJson(e))
          .toList();

      return getPriceFilterSearch;
    } else {
      isloadingmyquestions = false;
      notifyListeners();
      return getPriceFilterSearch;
    }
  }
}
