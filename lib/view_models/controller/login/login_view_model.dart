import 'package:anjuman_committee/res/routes/routes_name.dart';
import 'package:anjuman_committee/view_models/controller/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/app_exceptions.dart';
import '../../../models/login/user_model.dart';

import '../../../repository/login_repository/login_repository.dart';
import '../../../res/routes/app_routes.dart';
import '../../../utils/utils.dart';

class LoginViewModel extends GetxController {
  final api = LoginRepository();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  UserPreference userPreference = UserPreference();

  void loginApi() {
    Map data = {
      'email': emailController.value.text.trim(),
      'password': passwordController.value.text.trim(),
    };
    print('Calling login API with data: $data');

    /*api.loginApi(data).then((value) {
      if (value['error'] == 'user not found') {
        Utils.snackBar('Login...', value['error']);
      } else {
        UserModel userModel = UserModel(
          token: value['token'],
          isLogin: true,
        );
        userPreference.saveUser(userModel).then((value) {
          Get.toNamed(RoutesName.homeScreen);
          Utils.snackBar('Login', 'Login successfully!');
        }).onError((error, _) {
          Utils.toastMessage(error.toString());
        });
      }
    }).onError((error, stackTrace) {
      if (error is Map<String, dynamic>) {
        if (error.containsKey('error')) {
          Utils.snackBar('Login Failed', error['error']);
        } else {
          Utils.snackBar('Login Failed', 'Unexpected response format');
        }
      }
    });*/
    api
        .loginApi(data)
        .then((value) {
          print('Login response: $value');
          Get.offAllNamed(
            RoutesName.homeScreen,
          );
          // ✅ Ensure the value is a Map before accessing keys
          /*if (value is Map && value.containsKey('error')) {
            Utils.snackBar('Login Failed', value['error']);
          } else */
          /*if (value.containsKey('token')) {
            UserModel userModel = UserModel(
              token: value['token'],
              isLogin: true,
            );
            userPreference.saveUser(userModel).then((_) {
              Get.offAllNamed(
                RoutesName.homeScreen,
              ); // offAll removes backstack
              Utils.snackBar('Login', 'Login successfully!');
            });
          } else {
            Utils.snackBar('Login Failed', 'Token not found in response');
            print('Login Failed: $value, ${value['error']}');
          }*/
        })
        .onError((error, stackTrace) {
          print('Login error: $error');
          if (error is Map<String, dynamic> && error.containsKey('error')) {
            Utils.snackBar('Login Failed', error['error']);
          } else if (error is InternetException || error is RequestTimeoutException || error is ServerException) {
            Utils.snackBar('Login Failed', error.toString());
          } else {
            Utils.snackBar('Login Failed', 'Unexpected error');
          }
        });
  }
}
