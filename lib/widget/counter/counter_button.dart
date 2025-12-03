import 'package:flutter/material.dart';

import '../../state_management/inherited_widget/provider/counter_provider.dart';

class CounterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Button rebuild? No 🙂");

    return ElevatedButton(
      onPressed: () {
        CounterProvider.of(context).onIncrement();
      },
      child: Text("Increment"),
    );
  }
}
