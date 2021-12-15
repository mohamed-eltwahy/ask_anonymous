import 'package:ask_anonymous/model/authmodel.dart';
import 'package:ask_anonymous/myDio.dart';
import 'package:ask_anonymous/provider/apiLinks.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  bool _isloadingregister = false;
  bool isloadinglogin = false;
  bool _isloadingverify = false;
  bool isloadingresetpass = false;
  bool get isloadingverify => _isloadingverify;
  bool get isloadingregister => _isloadingregister;
   User user;
     SharedPreferences prefs;
   Future<SharedPreferences> initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }
///////////////////////////////////////register////////////////////////////
  dynamic register(
      {String name,
      String email,
      String password,
      String confirm,
      String deviceId}) async {
    _isloadingregister = true;
    notifyListeners();
    dynamic body = {
      "name": name,
      "email": email,
      "password": password,
      "confirm_password": confirm,
      "device_id": deviceId,
      "firebase_token": 'kfjydhstrgsgrg'
    };

    Map<dynamic, dynamic> register = await myDio(
        url: ApiLinks.baseUrl + ApiLinks.register,
        methodType: 'post',
        appLanguage: 'ar',
        dioBody: body);

    print('registewr ' + register.toString());

    if (register['status'] == true) {
      user = User.fromJson(register['data']);

      _isloadingregister = false;
      notifyListeners();
      return register;
    } else {
      _isloadingregister = false;
      notifyListeners();
      return register;
    }
  }

///////////////////////////////////////////verify account///////////////////////
  dynamic verify({
    String code,
    String email,
  }) async {
    _isloadingverify = true;
    notifyListeners();
    dynamic body = {
      "code": code,
      "email": email,
    };

    Map<dynamic, dynamic> verify = await myDio(
        url: ApiLinks.baseUrl + ApiLinks.verify,
        methodType: 'post',
        appLanguage: 'ar',
        dioBody: body);

    print('verified account ' + verify.toString());

    if (verify['status'] == true) {
      user = User.fromJson(verify['data']['user']);
      saveShared(user, verify['data']['token']);

      _isloadingverify = false;
      notifyListeners();
      return verify;
    } else {
      _isloadingverify = false;
      notifyListeners();
      return verify;
    }
  }

  //////////////////////////////login///////////////////////
  dynamic login({String email, String password, String deviceId}) async {
    isloadinglogin = true;
    notifyListeners();
    dynamic body = {
      "email": email,
      "password": password,
      "device_id": deviceId,
      "firebase_token": 'kfjydhstrgsgrg'
    };

    Map<dynamic, dynamic> login = await myDio(
        url: ApiLinks.baseUrl + ApiLinks.login,
        methodType: 'post',
        appLanguage: 'ar',
        dioBody: body);

    print('logined user ' + login.toString());

    if (login['status'] == true) {
      user = User.fromJson(login['data']['user']);
      saveShared(user, login['data']['token']);

      isloadinglogin = false;
      notifyListeners();
      return login;
    } else {
      isloadinglogin = false;
      notifyListeners();
      return login;
    }
  }

  //////////////////////////////////reset pass//////////////////////////
  dynamic resetpass({String email}) async {
    isloadingresetpass = true;
    notifyListeners();
    dynamic body = {
      "email": email,
    };

    Map<dynamic, dynamic> resetpass = await myDio(
        url: ApiLinks.baseUrl + ApiLinks.resetpass,
        methodType: 'post',
        appLanguage: 'ar',
        dioBody: body);

    print('reset pass ' + resetpass.toString());

    if (resetpass['status'] == true) {
      isloadingresetpass = false;
      notifyListeners();
      return resetpass;
    } else {
      isloadingresetpass = false;
      notifyListeners();
      return resetpass;
    }
  }



///////////////////////////////////////store local data/////////////
  saveShared(User user, String usertoken) async {
    SharedPreferences prefs;

    prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
    prefs.setString('token', usertoken);
    prefs.setInt('id', user.id);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('image', user.image);
    prefs.setString('link', user.link);
  }
}
