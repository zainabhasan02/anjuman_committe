import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widget/app_bar/custom_gradient_app_bar.dart';

class Home extends StatefulWidget{
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Home'),),);
  }
}