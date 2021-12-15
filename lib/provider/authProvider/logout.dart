
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../myDio.dart';
import '../apiLinks.dart';

class Logout with ChangeNotifier {
  bool _isloadinglogout = false;
  bool get isloadinglogout => _isloadinglogout;
   Future<SharedPreferences> prefs;
  update(Future<SharedPreferences> pref) {
    this.prefs = pref;
  }

  dynamic logout() async {
    _isloadinglogout = true;
    notifyListeners();
    String apitoken = await prefs.then((value) => value.getString('token'));

    Map<dynamic, dynamic> logout =await myDio(
        url: ApiLinks.baseUrl + ApiLinks.login,
        methodType: 'get',
        dioHeaders: {'Authorization': "Bearer $apitoken"},
        appLanguage: 'ar');
        print('logout '+logout.toString());
    if (logout['status'] == true) {
      Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences pref = await _prefs;
      pref.clear();
      pref.setBool('isLogin', false);
      _isloadinglogout = false;
      notifyListeners();
      return logout;
    } else {
      _isloadinglogout = false;
      notifyListeners();
      return logout;
    }
  }
}
