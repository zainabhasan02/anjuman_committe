import 'package:flutter/material.dart';

import '../../state_management/inherited_widget/provider/counter_provider.dart';

class CounterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("CounterText rebuild!!");   // Debug check
    final provider = CounterProvider.of(context);

    return Text(
      "Counter: ${provider.counter}",
      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    );
  }
}
