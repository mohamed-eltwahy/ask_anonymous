import 'package:ask_anonymous/model/messages.dart';
import 'package:ask_anonymous/provider/apiLinks.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../myDio.dart';

class GetMyReplies with ChangeNotifier {
  bool isloadingreplies = false;
  List<Messages>? getmyreplies;
  Future<dynamic> getmyrepliesdata() async {
    isloadingreplies = true;
    getmyreplies = [];
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? apitoken = pref.getString('token');
    dynamic header = {'Authorization': 'Bearer $apitoken'};
    Map<dynamic, dynamic> getPriceFilterSearch = await myDio(
        url: ApiLinks.baseUrl + ApiLinks.reply,
        methodType: 'get',
        appLanguage: 'ar',
        dioHeaders: header);
    print('replies ' + getPriceFilterSearch.toString());
    if (getPriceFilterSearch['status'] == true) {
      isloadingreplies = false;

      notifyListeners();
      getmyreplies = (getPriceFilterSearch['data'] as List)
          .map((e) => Messages.fromJson(e))
          .toList();

      return getPriceFilterSearch;
    } else {
      isloadingreplies = false;
      notifyListeners();
      return getPriceFilterSearch;
    }
  }
}
