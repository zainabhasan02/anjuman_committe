import 'package:anjuman_committee/views/auth/login/login.dart';
import 'package:anjuman_committee/widget/custom_styling/m_rounded_button.dart';
import 'package:anjuman_committee/widget/custom_styling/text_field_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/static_assets/assets_img.dart';
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

  String selectedCode = '+966';
  final List<Map<String, String>> countryCodes = [
    {'code': '+966', 'flag': '🇸🇦'},
    {'code': '+91', 'flag': '🇮🇳'},
  ];

  final List<String> cityItems = [
    'Jaipur',
    'Kota',
    'Udaipur',
    'Chittor',
    'Bikaner',
    'Jodhpur',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customGradientAppBar(title: 'Signup', showBack: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Form(
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
                  decoration: buildInputDecoration(
                    'Enter your name',
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
                  decoration: buildInputDecoration(
                    'Enter your email',
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
                // City
                DropdownButtonFormField<String>(
                  value: selectedCityValue,
                  hint: const Text("Select City"),
                  decoration: buildInputDecoration(
                    'Select a City',
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
                // Confirm Password
                TextFormField(
                  controller: confirmPasswordCtrl,
                  style: mTextStyle12(),
                  decoration: buildInputDecoration(
                    'Confirm Password',
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
                  btnName: 'Signup',
                  onPressed:
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
