import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/login/user_model.dart';

class UserPreference{
  Future<bool> saveUser(UserModel responseModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', responseModel.token!.toString());
    prefs.setBool('isLogin', responseModel.isLogin!);
    return true;
  }

  Future<UserModel> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    bool? isLogin = prefs.getBool('isLogin');
    return UserModel(token: token,isLogin: isLogin);
  }

  Future<bool> removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return true;
  }
}
