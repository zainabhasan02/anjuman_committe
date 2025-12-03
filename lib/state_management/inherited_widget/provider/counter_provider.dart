import 'package:flutter/cupertino.dart';

class CounterProvider extends InheritedWidget {
  final int counter;
  final VoidCallback onIncrement;

  const CounterProvider({
    super.key,
    required this.counter,
    required this.onIncrement,
    required Widget child,
  }) : super(child: child);

  // Getter for easily accessing data
  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>()!;
  }

  // Notifies widgets only when counter changes
  @override
  bool updateShouldNotify(CounterProvider oldWidget) {
    return counter != oldWidget.counter;
  }
}
