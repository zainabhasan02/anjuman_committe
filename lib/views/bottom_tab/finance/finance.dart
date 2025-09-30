import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/colours/app_colors.dart';
import '../../../widget/app_bar/custom_gradient_app_bar.dart';
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
      length: 4,
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
          tabs: [Tab(text: 'Summary'), Tab(text: 'Details')],
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Summary')),
            Center(child: Text('Details')),
          ],
        ),
      ),
    );
  }
}
