import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../res/routes/routes_name.dart';
import '../../../widget/app_bar/custom_gradient_app_bar.dart';
import 'animated_box.dart';

class MyAnimation extends StatefulWidget {
  const MyAnimation({super.key});

  @override
  State<MyAnimation> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  List<int> itemList = List.generate(30, (index) => index);

  late AnimationController _animationController;

  //late Animation<Offset> _animation;

  late Animation<Offset> slide1; // Right → Center
  late Animation<Offset> slide2; // Left → Center
  late Animation<Offset> slide3; // Bottom → Center
  late Animation<Offset> slide4; // Top → Center
  late Animation<double> fade5; // Fade-in

  // MULTIPLE GRADIENTS LIST
  final List<List<Color>> gradientList = [
    [Colors.amber, Colors.pink],
    [Colors.lightGreen.shade100, Colors.green],
    [Colors.deepOrange, Colors.black],
    [Colors.white, Colors.teal],
    [Colors.purpleAccent, Colors.blue],
    [Colors.yellow, Colors.red],
    [Colors.cyan, Colors.indigo],
    [Colors.lime, Colors.orange],
    [Colors.teal, Colors.blueGrey],
  ];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadMore();
        //_animationController.reset();
        //_animationController.forward();
      }
    });

    /*scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _animationController.forward();
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _animationController.reverse();
      }
    });*/

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    /*_animation = Tween<Offset>(
      begin: Offset(1.0, 1.0),
      end: Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );*/
    // CONTAINER 1 (Right -> Center)
    slide1 = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    // CONTAINER 2 (Left -> Center)
    slide2 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.1, 0.5, curve: Curves.easeOut),
      ),
    );

    // CONTAINER 3 (Bottom -> Center)
    slide3 = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.2, 0.6, curve: Curves.easeOut),
      ),
    );

    // CONTAINER 4 (Top -> Center)
    slide4 = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    // CONTAINER 5 (Fade In)
    fade5 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );
    _animationController.forward();
  }

  void _loadMore() {
    Future.delayed(
      Duration(seconds: 2),
      () => setState(() {
        itemList.addAll(List.generate(30, (index) => index));
      }),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customGradientAppBar(title: 'Custom  Multi Animation'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SlideTransition(
              position: slide1,
              child: containerBox([Colors.amber, Colors.pink]),
            ),

            SlideTransition(
              position: slide2,
              child: containerBox([Colors.lightGreen.shade100, Colors.green]),
            ),

            SlideTransition(
              position: slide1,
              child: containerBox([Colors.pink.shade200, Colors.purpleAccent]),
            ),

            SlideTransition(
              position: slide2,
              child: containerBox([Colors.white, Colors.teal]),
            ),

            SlideTransition(
              position: slide1,
              child: containerBox([Colors.deepOrange, Colors.black]),
            ),

            */ /*FadeTransition(
              opacity: fade5,
              child: containerBox([Colors.pink.shade200, Colors.purpleAccent]),
            ),*/ /*

            */ /*Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.amber, Colors.pink]),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepOrange, Colors.black],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightGreen.shade200, Colors.green],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.white, Colors.teal]),
              ),
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.pink.shade200, Colors.purpleAccent],
                ),
              ),
            ),*/ /*
          ],
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customGradientAppBar(title: 'Custom  Multi Animation'),
      body: ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          return SlideTransition(
            position: slide1,
            child: InkWell(
              onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => AnimatedBox(animationController: _animationController,)),
              ),
              child: containerBox(
                [Colors.amber.shade100, Colors.pink.shade200],
                150,
                'Item ${itemList[index]+1}',
              ),
            ),
          );
        },
        separatorBuilder:
            (context, index) => SlideTransition(
              position: slide2,
              child: containerBox(
                [Colors.pink, Colors.amber], // 🔥 separator color
                10,
                '',
              ),
            ),
        itemCount: itemList.length,
      ),
    );
  }

  Widget containerBox(List<Color> colors, double height, String index) {
    return Container(
      width: double.infinity,
      height: height,
      //margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(gradient: LinearGradient(colors: colors)),
      child: Center(
        child:
            index.isNotEmpty
                ? Text(
                  "$index.",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                )
                : SizedBox(),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
