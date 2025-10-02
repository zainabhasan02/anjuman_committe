import 'package:anjuman_committee/res/routes/app_routes.dart';
import 'package:anjuman_committee/utils/utils.dart';
import 'package:anjuman_committee/view_models/controller/language_controller.dart';
import 'package:anjuman_committee/widget/app_bar/custom_gradient_app_bar.dart';
import 'package:anjuman_committee/widget/custom_styling/m_rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/routes/routes_name.dart';
import '../../../view_models/controller/login/login_view_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final loginVM = Get.put(LoginViewModel());
  final formKey = GlobalKey<FormState>();

  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  bool isChecked = false;
  bool _obscurePassword = true; // 👈 Hidden by default

  final LanguageController languageController = Get.put(LanguageController());

  // supported locales to display in UI
  final List<Locale> _supportedLocales = [
    const Locale('en', 'US'),
    const Locale('hi', 'IN'),
    const Locale('ur', 'PK'),
  ];

  String localeToLabel(Locale locale) {
    if (locale.languageCode == 'en') return 'english'.tr;
    if (locale.languageCode == 'hi') return 'hindi'.tr;
    if (locale.languageCode == 'ur') return 'urdu'.tr;
    return locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customGradientAppBar(
        title: 'app_title'.tr,

      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: loginVM.emailController.value,
                    focusNode: loginVM.emailFocusNode.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter_email'.tr; // ✅ return error string
                      }
                      return null;
                    },
                    onFieldSubmitted: (value) {
                      Utils.fieldFocusChange(
                        context,
                        loginVM.emailFocusNode.value,
                        loginVM.passwordFocusNode.value,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'eve.holt@reqres.in'.tr,
                      labelText: 'eve.holt@reqres.in'.tr,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: loginVM.passwordController.value,
                    focusNode: loginVM.passwordFocusNode.value,
                    obscureText: false,
                    /*obscuringCharacter: '*',*/
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please_enter_password'.tr;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'cityslicka',
                      labelText: 'cityslicka',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            MRoundedButton(
              btnName: 'login'.tr,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print('Form is valid');
                  loginVM.loginApi();
                } else {
                  print('Form is invalid');
                }
              },
            ),

            SizedBox(height: 10),
            MRoundedButton(
              btnName: 'signup'.tr,
              onPressed: () => Get.toNamed(RoutesName.signupScreen),
            ),
          ],
        ),
      ),
    );
  }
}
