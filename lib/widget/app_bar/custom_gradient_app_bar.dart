import 'package:anjuman_committee/widget/custom_styling/m_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/colours/app_colors.dart';
import '../../view_models/controller/translations/language_controller.dart';

AppBar customGradientAppBar({
  required String title,
  bool showBack = true,
  List<Widget>? actions,
}) {
  final LanguageController languageController = Get.put(LanguageController());
  // Gear icon as default action
  final settingsAction = PopupMenuButton<Locale>(
    icon: Icon(Icons.settings),
    onSelected: (Locale locale) {
      languageController.changeLocale(locale);
    },
    itemBuilder: (_) => [
      PopupMenuItem(value: const Locale('en', 'US'), child: Text('english'.tr)),
      PopupMenuItem(value: const Locale('hi', 'IN'), child: Text('hindi'.tr)),
      PopupMenuItem(value: const Locale('ur', 'PK'), child: Text('urdu'.tr)),
    ],
  );
  return AppBar(
    automaticallyImplyLeading: showBack,
    title: Text(title, style: mTextStyle18(mFontWeight: FontWeight.bold)),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    //no shadow
    actions: [
      if (actions != null) ...actions, // other optional actions
      settingsAction, // always add settings gear icon
    ],
    flexibleSpace: _GradientBackground(),
  );
}

class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.pastelYellow, AppColors.limeStoned],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
