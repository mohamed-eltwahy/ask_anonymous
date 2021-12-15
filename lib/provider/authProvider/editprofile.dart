import 'package:ask_anonymous/model/authmodel.dart';
import 'package:ask_anonymous/myDio.dart';
import 'package:ask_anonymous/provider/apiLinks.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProvider with ChangeNotifier {
  bool isloadingedit = false;
  User user;

  dynamic updateUser({String name, String email}) async {
    isloadingedit = true;
    notifyListeners();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String apitoken = pref.getString('token');

    Map<dynamic, dynamic> updateUser = await myDio(
      url: ApiLinks.baseUrl + ApiLinks.updateuser,
      methodType: 'post',
      appLanguage: 'ar',
          dioHeaders: {'Authorization': "Bearer $apitoken"},
      dioBody: {"name": name, "email": email},
    );
    print('updateUser =====> ' + updateUser.toString());
    if (updateUser['status'] == true) {
      isloadingedit = false;
      notifyListeners();

      /////////////////update data user
      user = User.fromJson(updateUser['data']);
      saveShared(user);
//pref.get(key)
      return updateUser;
    } else {
      isloadingedit = false;
      notifyListeners();
      return updateUser;
    }
  }

  saveShared(User user) async {
    SharedPreferences prefs;

    prefs = await SharedPreferences.getInstance();
    prefs.setInt('id', user.id);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('image', user.image);
    prefs.setString('link', user.link);
  }
}
