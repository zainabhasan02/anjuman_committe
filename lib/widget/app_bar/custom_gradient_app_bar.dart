import 'package:anjuman_committee/widget/custom_styling/m_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/colours/app_colors.dart';

AppBar customGradientAppBar({
  required String title,
  bool showBack = true,
  List<Widget>? actions,
}) {
  return AppBar(
    automaticallyImplyLeading: showBack,
    title: Text(title, style: mTextStyle18(mFontWeight: FontWeight.bold)),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0,
    //no shadow
    actions: actions,
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
