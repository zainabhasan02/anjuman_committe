import 'package:anjuman_committee/widget/app_bar/custom_gradient_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../state_management/inherited_widget/provider/counter_provider.dart';
import '../../../widget/counter/counter_button.dart';
import '../../../widget/counter/counter_text.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);

    return Scaffold(
      appBar: customGradientAppBar(title: 'InheritedWidget Demo`'),
      body: Column(
        children: [
          CounterText(),
          // Only this rebuilds → because it depends on data
          SizedBox(height: 20),
          CounterButton(),
          // Uses increment function
          SizedBox(height: 20),
          Text(
            "Below widget does NOT rebuild!",
            style: TextStyle(color: Colors.grey),
          ),
          StaticWidget(), // This does NOT rebuild
        ],
      ),
    );
  }
}

class StaticWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Static widget build hua!");
    return Text(
      "I don't rebuild 😊",
      style: TextStyle(fontSize: 18, color: Colors.blueGrey),
    );
  }
}
