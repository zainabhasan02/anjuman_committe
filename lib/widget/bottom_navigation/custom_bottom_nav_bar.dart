import 'package:anjuman_committee/core/theme/colours/app_colors.dart';
import 'package:anjuman_committee/views/bottom_tab/finance/finance.dart';
import 'package:anjuman_committee/views/bottom_tab/news/news.dart';
import 'package:anjuman_committee/widget/custom_styling/m_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../views/bottom_tab/home/home.dart';
import '../app_bar/custom_gradient_app_bar.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [const Home(), const Finance(), const News()];
  final List<String> _titles = ['Home', 'Finance', 'News'];

  void onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
