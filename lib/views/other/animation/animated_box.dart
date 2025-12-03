import 'package:flutter/material.dart';

class AnimatedBox extends StatelessWidget {
  final AnimationController animationController;

  const AnimatedBox({required this.animationController, super.key});

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: animationController.value * 2 * 3.1416,
          child: Container(width: 100, height: 100, color: Colors.teal),
        );
      },
    );
  }
}
