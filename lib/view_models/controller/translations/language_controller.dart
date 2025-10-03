import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  static const String _storageKey = 'selectedLocale';
  final box = GetStorage();

  /// Observable locale
  final Rx<Locale> locale = const Locale('en', 'US').obs;

  Locale get currentLocale => locale.value;

  // call to change language
  Future<void> changeLocale(Locale newLocale) async {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    await box.write(
      _storageKey,
      '${newLocale.languageCode}_${newLocale.countryCode ?? ''}',
    );
  }

  // load from storage during startup
  Future<void> loadLocaleFromStorage() async {
    final stored = box.read<String>(_storageKey);
    if (stored != null) {
      final parts = stored.split('_');
      if (parts.isNotEmpty) {
        final language = parts[0];
        final countryCode = parts.length > 1 && parts[1].isNotEmpty ? parts[1] : null;
        locale.value = Locale(language, countryCode);
        Get.updateLocale(locale.value);
      }
    }
  }

}
