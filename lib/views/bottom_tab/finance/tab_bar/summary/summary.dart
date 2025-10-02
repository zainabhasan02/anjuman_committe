import 'package:anjuman_committee/widget/app_bar/custom_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customGradientAppBar(title: 'summary'.tr),
      body: Center(child: Text('summary'.tr)),
    );
  }
}
