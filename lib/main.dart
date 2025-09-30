import 'package:anjuman_committee/firebase_options.dart';
import 'package:anjuman_committee/getx_localization/language.dart';
import 'package:anjuman_committee/res/routes/app_routes.dart';
import 'package:anjuman_committee/res/routes/routes_name.dart';
import 'package:anjuman_committee/views/auth/splash/Splash.dart';
import 'package:anjuman_committee/views/bottom_tab/finance/finance.dart';
import 'package:anjuman_committee/views/bottom_tab/home/home.dart';
import 'package:anjuman_committee/views/bottom_tab/news/news.dart';
import 'package:anjuman_committee/views/other/contacts.dart';
import 'package:anjuman_committee/widget/app_bar/custom_gradient_app_bar.dart';
import 'package:anjuman_committee/widget/custom_styling/m_text_style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'core/theme/colours/app_colors.dart';
import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  runApp(const MyApp());
}

// Background handler
@pragma('vm:entry-point') // 👈 Add this line
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('onBackgroundMessage: ${message.data.toString()}');
  print('onBackgroundMessage title: ${message.notification!.title}');
  print('onBackgroundMessage body: ${message.notification!.body}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      /*theme:  ThemeData(
        fontFamily: 'NotoNastaliq',
      ),
      translations: Language(),
      locale: Locale('ur', 'IN'),
      fallbackLocale: Locale('ur', 'IN'),*/
      initialRoute: RoutesName.splashScreen,
      getPages: AppRoutes.appRoutes(),
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
  final List<String> _titles = ['Home', 'Finance', 'News'];

  void onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customGradientAppBar(
        title: _titles[_selectedIndex],
        showBack: false,
        actions: [
          IconButton(
            onPressed: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );*/
            },
            icon: Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Contacts()),
              );
            },
            icon: Icon(Icons.contacts),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.oliveGreen,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: mTextStyle14(mFontWeight: FontWeight.bold),
        showUnselectedLabels: true,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Finance'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
        ],
      ),
    );
  }
}
