import 'package:anjuman_committee/res/routes/routes_name.dart';
import 'package:anjuman_committee/utils/utils.dart';
import 'package:anjuman_committee/views/auth/login/login.dart';
import 'package:anjuman_committee/widget/custom_styling/m_rounded_button.dart';
import 'package:anjuman_committee/widget/custom_styling/text_field_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/theme/static_assets/assets_img.dart';
import '../../../res/routes/app_routes.dart';
import '../../../widget/app_bar/custom_gradient_app_bar.dart';
import '../../../widget/custom_styling/m_text_style.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();

  bool isChecked = false;
  bool _obscurePassword = true; // 👈 Hidden by default
  bool _obscureConfirmPassword = true; // 👈 Hidden by default

  String? selectedCityValue;

  final _formKey = GlobalKey<FormState>();
  String selectedCode = '+966';
  final List<Map<String, String>> countryCodes = [
    {'code': '+966', 'flag': '🇸🇦'},
    {'code': '+91', 'flag': '🇮🇳'},
  ];

  final List<String> cityItems = [
    'jaipur'.tr,
    'kota'.tr,
    'udaipur'.tr,
    'chittor'.tr,
    'bikaner'.tr,
    'jodhpur'.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customGradientAppBar(title: 'signup'.tr, showBack: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10),
                // logo
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(AssetsImg.logo),
                ),
                SizedBox(height: 12),
                // Name
                TextFormField(
                  controller: nameCtrl,
                  style: mTextStyle12(),
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${'please_enter'.tr} ${'enter_name'.tr.toLowerCase()}';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: buildInputDecoration(
                    'enter_name'.tr,
                    Icons.person,
                  ).copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        nameCtrl.clear();
                      },
                      icon: Icon(CupertinoIcons.clear_circled, size: 20),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // Email
                TextFormField(
                  controller: emailCtrl,
                  style: mTextStyle12(),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${'please_enter'.tr} ${'enter_email'.tr.toLowerCase()}';
                    }
                    if (!value.contains('@')) {
                      return 'enter_valid_email'.tr;
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: buildInputDecoration(
                    'enter_email'.tr,
                    Icons.email_outlined,
                  ).copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        emailCtrl.clear();
                      },
                      icon: Icon(CupertinoIcons.clear_circled, size: 20),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                // Mobile Number
                TextFormField(
                  controller: phoneCtrl,
                  style: mTextStyle12(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${'please_enter'.tr} ${'mobile_number'.tr.toLowerCase()}';
                    }
                    if (value.length != 10) {
                      return 'enter_valid_mobile'.tr;;
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: buildInputDecoration(
                    'mobile_number'.tr,
                    Icons.phone,
                  ).copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        phoneCtrl.clear();
                      },
                      icon: Icon(CupertinoIcons.clear_circled, size: 20),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length == 10) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 15),
                // City
                DropdownButtonFormField<String>(
                  value: selectedCityValue,
                  hint:  Text('select_city'.tr),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${'please_select'.tr} ${'select_city'.tr.toLowerCase()}';
                    }
                    return null;
                  },
                  decoration: buildInputDecoration(
                    'select_city'.tr,
                    Icons.location_city,
                  ),
                  dropdownColor: Colors.yellow.shade100,
                  onChanged: (value) {
                    setState(() {
                      selectedCityValue = value;
                      //cityError = null;
                    });
                  },
                  items:
                      cityItems.map((city) {
                        return DropdownMenuItem(
                          value: city,
                          child: Text(city, style: mTextStyle12()),
                        );
                      }).toList(),
                ),
                SizedBox(height: 15),
                // Password
                TextFormField(
                  controller: passwordCtrl,
                  style: mTextStyle12(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please_enter_password'.tr;
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: buildInputDecoration(
                    'password'.tr,
                    Icons.password_outlined,
                  ).copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword =
                              !_obscurePassword; //When tapped:If the password is hidden → it shows it.If the password is shown → it hides it
                        });
                      },
                      icon: Icon(
                        size: 20,
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _obscurePassword,
                ),
                SizedBox(height: 10),
                // Confirm Password
                TextFormField(
                  controller: confirmPasswordCtrl,
                  style: mTextStyle12(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please_enter_confirm_password'.tr;
                    }
                    if (value != passwordCtrl.text) {
                      return 'password_not_match'.tr;
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.visiblePassword,

                  decoration: buildInputDecoration(
                    'confirm_password'.tr,
                    Icons.password_outlined,
                  ).copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword =
                              !_obscureConfirmPassword; //When tapped:If the password is hidden → it shows it.If the password is shown → it hides it
                        });
                      },
                      icon: Icon(
                        size: 20,
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _obscureConfirmPassword,
                ),
                SizedBox(height: 20),
                // Signup
                MRoundedButton(
                  btnName: 'signup'.tr,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print('Form is valid');
                      Get.toNamed(RoutesName.homeScreen);
                      Utils.snackBarBottom('signup'.tr, 'registered_success'.tr);
                    } else {
                      Utils.snackBarBottom('signup'.tr, 'form_invalid'.tr);
                      print('Form is invalid');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
