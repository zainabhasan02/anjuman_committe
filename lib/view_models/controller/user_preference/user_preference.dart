import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/login/user_model.dart';

class UserPreference {
  Future<bool> saveUser(UserModel user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('token', user.token ?? '');
    await sp.setBool('isLogin', user.isLogin ?? false);
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    bool? isLogin = sp.getBool('isLogin');

    return UserModel(
      token: token,
      isLogin: isLogin,
    );
  }

  Future<bool> clearUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}
