import 'package:anjuman_committee/fcm/firebase_options.dart';
import 'package:anjuman_committee/res/routes/app_routes.dart';
import 'package:anjuman_committee/res/routes/routes_name.dart';
import 'package:anjuman_committee/translations/app_translations.dart';
import 'package:anjuman_committee/view_models/controller/theme/theme_controller.dart';
import 'package:anjuman_committee/view_models/controller/translations/language_controller.dart';
import 'package:anjuman_committee/views/bottom_tab/finance/finance.dart';
import 'package:anjuman_committee/views/bottom_tab/home/home.dart';
import 'package:anjuman_committee/views/bottom_tab/news/news.dart';
import 'package:anjuman_committee/widget/app_bar/custom_gradient_app_bar.dart';
import 'package:anjuman_committee/widget/custom_styling/m_text_style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/theme/colours/app_colors.dart';
import 'view_models/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init(); // initialize local storage
  final LanguageController languageController = LanguageController();
  await languageController.loadLocaleFromStorage();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) {
      //when user taps Notification
      Get.toNamed(RoutesName.notificationScreen, arguments: details.payload);
    },
  );

  final NotificationService notificationService = NotificationService(
    flutterLocalNotificationsPlugin,
  );
  await notificationService.initFCM();

  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  /// Using Getx
  runApp(MyApp(languageController: languageController));
}

// Background handler
@pragma('vm:entry-point') // 👈 Add this line
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('onBackgroundMessage: ${message.data.toString()}');
  print('onBackgroundMessage title: ${message.notification!.title}');
  print('onBackgroundMessage body: ${message.notification!.body}');
}

class MyApp extends StatelessWidget {
  final LanguageController languageController;

  const MyApp({Key? key, required this.languageController}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: AppTranslations(),
      locale: languageController.currentLocale,
      // // initial locale
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: RoutesName.splashScreen,
      getPages: AppRoutes.appRoutes(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeController.theme,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [const Home(), const Finance(), const News()];
  final List<String> _titles = ['home'.tr, 'finance'.tr, 'news'.tr];

  void onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return Scaffold(
      appBar: customGradientAppBar(
        title: _titles[_selectedIndex],
        showBack: false,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(RoutesName.contactScreen),
            icon: Icon(Icons.contacts),
          ),
          IconButton(
            onPressed: () => Get.toNamed(RoutesName.paymentScreen),
            icon: Icon(Icons.paypal_outlined),
          ),
          IconButton(
            onPressed: () => themeController.toggleTheme(),
            icon: Obx(
              () => Icon(
                themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color:
                    themeController.isDarkMode.value
                        ? Colors.black
                        : Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.oliveGreen,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: mTextStyle14(
          mFontWeight: FontWeight.bold,
          textColor:
              themeController.isDarkMode.value ? Colors.white : Colors.black,
        ),
        showUnselectedLabels: true,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home".tr),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: "finance".tr),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: "news".tr,
          ),
        ],
      ),
    );
  }
}
