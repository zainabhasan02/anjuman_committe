import 'package:anjuman_committee/main.dart';
import 'package:anjuman_committee/res/routes/routes_name.dart';
import 'package:anjuman_committee/views/auth/login/login.dart';
import 'package:anjuman_committee/views/auth/signup/signup.dart';
import 'package:anjuman_committee/views/other/contact/contacts.dart';
import 'package:anjuman_committee/views/other/payment_gateway/razor_payment_screen.dart';
import 'package:get/get.dart';

import '../../views/auth/splash/Splash.dart';
import '../../views/other/notification/notification_screen.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RoutesName.splashScreen,
      page: () => Splash(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 2500),
    ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () => Login(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 2500),
    ),
    GetPage(
      name: RoutesName.signupScreen,
      page: () => Signup(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 2500),
    ),
    GetPage(
      name: RoutesName.homeScreen,
      page: () => MyHomePage(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 2500),
    ),
    GetPage(
      name: RoutesName.notificationScreen,
      page: () => NotificationScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 300),
    ),
    GetPage(
      name: RoutesName.paymentScreen,
      page: () => RazorPaymentScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 800),
    ),
    GetPage(name: RoutesName.contactScreen, page: () => Contacts()),
  ];
}
