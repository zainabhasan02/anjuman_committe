import 'dart:convert';

import 'package:anjuman_committee/res/routes/routes_name.dart';
import 'package:anjuman_committee/view_models/controller/user_preference/user_preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../repository/login_repository/login_repository.dart';

class LoginViewModel extends GetxController {
  final api = LoginRepository();

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  UserPreference userPreference = UserPreference();

  void loginApi() async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": emailController.value.text.trim(),
        "password": passwordController.value.text.trim(),
      }),
    );

    print("Status: ${response.statusCode}");
    print("Body: ${response.body}");

    Get.offAllNamed(RoutesName.homeScreen);
    /*if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['token'] != null) {
        UserModel userModel = UserModel(token: data['token'], isLogin: true);

        await userPreference.saveUser(userModel);

        print("User saved: ${data['token']}");

        Get.offAllNamed(RoutesName.homeScreen);
        Utils.snackBar('Login', 'Login successfully!');
      }
    } else {
      final errorData = jsonDecode(response.body);
      Utils.snackBar("Login Failed", errorData["error"] ?? "Unknown error");
    }*/
  }
}
