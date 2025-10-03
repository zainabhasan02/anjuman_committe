import 'dart:convert';

import 'package:anjuman_committee/widget/app_bar/custom_gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = jsonDecode(Get.arguments);
    print('args: $args');
    final title = args['title'];
    final body = args['body'];
    print('Title: $title, Body: $body');

    return Scaffold(
      appBar: customGradientAppBar(title: 'notification'.tr),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(textAlign: TextAlign.center,
            '$title\n$body',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
