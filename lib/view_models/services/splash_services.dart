import 'dart:async';

import 'package:anjuman_committee/res/routes/routes_name.dart';
import 'package:anjuman_committee/view_models/controller/user_preference/user_preference.dart';
import 'package:get/get.dart';

import '../../res/routes/app_routes.dart';

class SplashServices {
  UserPreference userPreferenceViewModel = UserPreference();

  void isLogin() {
    userPreferenceViewModel.getUser().then((value) {
      print('Token: ${value.token}');
      print('isLogin: ${value.isLogin}');
      final token = value.token;
      final isLoggedIn = token != null && token.isNotEmpty && token != 'null';

      if (value.isLogin == false || value.isLogin.toString() == 'null') {
        Timer(
          const Duration(seconds: 3),
              () => Get.toNamed(RoutesName.loginScreen),
        );
      } else {
        Timer(const Duration(seconds: 3),
              () => Get.toNamed(RoutesName.homeScreen),
        );
      }
      /*Timer(
        const Duration(seconds: 3),
            () => Get.toNamed(isLoggedIn ? RoutesName.homeScreen : RoutesName.loginScreen),
      );*/
      print('isLoggedIn: $isLoggedIn');

    });
  }
}
