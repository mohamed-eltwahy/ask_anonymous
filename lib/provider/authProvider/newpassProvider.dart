import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../myDio.dart';
import '../apiLinks.dart';

class NewPassProvider with ChangeNotifier {
  bool isloadingnewpass = false;
   Future<SharedPreferences> prefs;
  update(Future<SharedPreferences> pref) {
    this.prefs = pref;
  }

  ////////////////////////////////////////////////new pass///////////////////
  dynamic newpass({String newpassword, String confirmpass}) async {
    isloadingnewpass = true;
    notifyListeners();
    String apitoken = await prefs.then((value) => value.getString('token'));

    dynamic header = {'Authorization': 'Bearer $apitoken'};
    dynamic body = {
      "new_password": newpassword,
      "confirm_new_password": confirmpass,
    };

    Map<dynamic, dynamic> newpass = await myDio(
        url: ApiLinks.baseUrl + ApiLinks.newpass,
        methodType: 'post',
        appLanguage: 'ar',
        dioHeaders: header,
        dioBody: body);

    print('newpass ' + newpass.toString());

    if (newpass['status'] == true) {
      isloadingnewpass = false;
      notifyListeners();
      return newpass;
    } else {
      isloadingnewpass = false;
      notifyListeners();
      return newpass;
    }
  }
}
