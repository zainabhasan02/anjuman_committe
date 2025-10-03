import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  // Observable theme mode
  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    // load theme from storage
    isDarkMode.value = _box.read(_key) ?? false;
  }

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    _box.write(_key, isDarkMode.value);
    Get.changeThemeMode(theme);
  }

}
