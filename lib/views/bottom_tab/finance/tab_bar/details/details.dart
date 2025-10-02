import 'package:anjuman_committee/widget/app_bar/custom_gradient_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customGradientAppBar(title: 'details'.tr),
      body: Center(child: Text('details'.tr)),
    );
  }
}
