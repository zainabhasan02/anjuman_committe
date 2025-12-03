import 'package:anjuman_committee/widget/app_bar/custom_gradient_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/colours/app_colors.dart';

class MyGestureDetector extends StatefulWidget {
  const MyGestureDetector({super.key});

  @override
  State<MyGestureDetector> createState() => _MyGestureDetectorState();
}

class _MyGestureDetectorState extends State<MyGestureDetector> {
  Color _backgroundColor = Colors.blue; // Initial background color

  void _changeColorOnSwipe(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // Swipe right
      setState(() {
        _backgroundColor = Colors.green;
      });
    } else if (details.delta.dx < 0) {
      // Swipe left
      setState(() {
        _backgroundColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customGradientAppBar(title: 'Gesture Detector'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Original Image
              Image.network(
                'https://media.geeksforgeeks.org/wp-content/cdn-uploads/20220512131412/Student-Chapter-Article-Banner.png',
                width: 300.0,
                height: 300.0,
                fit: BoxFit.cover,
              ),
              Text(
                "Original Image",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20.0), // Add some spacing between the images
              // Image with ShaderMask
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  // Create a linear gradient shader for the mask
                  return LinearGradient(
                    colors: [AppColors.pastelYellow, AppColors.pastelYellow],
                    //stops: [0.5, 0.9],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds);
                },
                child: Image.network(
                  'https://media.geeksforgeeks.org/wp-content/cdn-uploads/20220512131412/Student-Chapter-Article-Banner.png',
                  width: 300.0,
                  height: 300.0,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "Shadered Image",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0), // Add some spacing between the images
              GestureDetector(
                onHorizontalDragUpdate: _changeColorOnSwipe,
                // Call the function on horizontal drag
                child: Container(
                  width: 200,
                  height: 200,
                  color: _backgroundColor, // Use the current background color
                  child: Center(
                    child: Text(
                      'Swipe me!',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
