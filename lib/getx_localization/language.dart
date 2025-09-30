import 'package:get/get_navigation/get_navigation.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'login': 'Login',
      'home': 'Home',
      'finance': 'Finance',
      'news': 'News',
      'email_hint': 'Email',
      'password_hint': 'Password',
    },
    'ur_IN': {
      'login': 'لاگ ان',
      'home': 'ہوم',
      'finance': 'مالیات',
      'news': 'خبریں',
    },
  };
}
