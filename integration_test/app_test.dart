import 'package:anjuman_committee/view_models/controller/translations/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get/get.dart';

import 'package:anjuman_committee/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full App Flow Test: Login → Home', (WidgetTester tester) async {
    // Inject Controller
    final languageController = LanguageController();
    Get.put(languageController);

    // Start App
    app.main();
    //await tester.pumpWidget(MyApp(languageController: languageController));
    await tester.pumpAndSettle(const Duration(seconds: 3)); // WAIT until UI loaded

    // Find UI elements
    final emailField = find.byKey(const Key('email'));
    final passwordField = find.byKey(const Key('password'));
    final loginButton = find.byKey(const Key('loginButton'));

    // Enter login details
    await tester.enterText(emailField, 'eve.holt@reqres.in');
    await tester.enterText(passwordField, 'cityslicka');

    // Tap login button
    await tester.tap(loginButton);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Validate navigation success
    final bottomNavFinder = find.byKey(const Key('BottomNavigationBar'));
    expect(bottomNavFinder, findsOneWidget);

    debugPrint(tester.allWidgets.toString());

  });
}
