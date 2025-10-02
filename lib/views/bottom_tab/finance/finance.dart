import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/colours/app_colors.dart';
import '../../../widget/custom_styling/m_text_style.dart';

class Finance extends StatefulWidget {
  const Finance({super.key});

  @override
  State<Finance> createState() => _FinanceState();
}

class _FinanceState extends State<Finance> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          indicator: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.oliveGreen, AppColors.pastelGold],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelStyle: mTextStyle14(),
          labelStyle: mTextStyle14(mFontWeight: FontWeight.bold, textColor: AppColors.white),
          tabs: [Tab(text: 'summary'.tr), Tab(text: 'details'.tr)],
        ),
        body:  TabBarView(
          children: [
            Center(child: Text('summary'.tr)),
            Center(child: Text('details'.tr)),
          ],
        ),
      ),
    );
  }
}
