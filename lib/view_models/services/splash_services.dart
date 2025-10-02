import 'dart:async';

import 'package:anjuman_committee/res/routes/routes_name.dart';
import 'package:anjuman_committee/view_models/controller/user_preference/user_preference.dart';
import 'package:get/get.dart';

import '../../res/routes/app_routes.dart';

class SplashServices {
  UserPreference userPreferenceViewModel = UserPreference();

  void isLogin() {
    UserPreference userPreferenceViewModel = UserPreference();

    userPreferenceViewModel.getUser().then((value) {
      final isLoggedIn =
          (value.isLogin ?? false) && (value.token?.isNotEmpty ?? false);

      print("Token: ${value.token}");
      print("isLogin: ${value.isLogin}");

      Timer(
        const Duration(seconds: 3),
        () => Get.offAllNamed(
          isLoggedIn ? RoutesName.homeScreen : RoutesName.loginScreen,
        ),
      );
    });
  }
}
