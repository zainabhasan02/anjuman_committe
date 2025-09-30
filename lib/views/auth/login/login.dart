import 'package:anjuman_committee/utils/utils.dart';
import 'package:anjuman_committee/widget/app_bar/custom_gradient_app_bar.dart';
import 'package:anjuman_committee/widget/custom_styling/m_rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customGradientAppBar(
        title: 'Login',
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      /*body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              // logo
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(AssetsImg.logo),
              ),
              SizedBox(height: 12),
              Form(
                child: Column(
                  children: [
                    // Mobile Number
                    TextFormField(
                      controller: phoneCtrl,
                      style: mTextStyle12(),
                      decoration: buildInputDecoration(
                        'Mobile Number',
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
                      maxLength: 10,
                    ),
                    // Password
                    TextFormField(
                      controller: passwordCtrl,
                      style: mTextStyle12(),
                      decoration: buildInputDecoration(
                        'Password',
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
                    // Check Box and Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            Text('Remember Me', style: mTextStyle12()),
                          ],
                        ),
                        Text(
                          'Forgot Passwords',
                          style: mTextStyle12(
                            textColor: Colors.lightBlue,
                          ).copyWith(decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    // Login Button
                    MRoundedButton(
                      btnName: 'Login',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    MRoundedButton(
                      btnName: 'Signup',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),*/
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
                        return 'Please enter email'; // ✅ return error string
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
                        return 'Please enter password';
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
          ],
        ),
      ),
    );
  }
}
