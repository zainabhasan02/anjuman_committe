
import 'package:anjuman_committee/core/theme/colours/app_colors.dart';
import 'package:anjuman_committee/view_models/services/splash_services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/theme/static_assets/assets_img.dart';
import '../../../main.dart';
import '../login/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _lottieController;
  late AnimationController _textController;
  late Animation<double> _textAnimation;
  bool _fadeOut = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);

    _textController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 20.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    _textController.repeat(reverse: true); // bounce effect

    // Play sound
    //_audioPlayer.play(AssetSource('sounds/guitar.mp3'));

    // Navigate after 4 seconds with fade
    /*Timer(Duration(seconds: 4), () {
      setState(() => _fadeOut = true);
      Future.delayed(Duration(milliseconds: 700), () {
        _navigateToHome();
      });
    });*/

    splashServices.isLogin();

    /*_controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const MyHomePage()),
          );
        }
      });*/
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => const Login(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  /*_scaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MyHomePage()),
      );
    });*/

  @override
  void dispose() {
    _lottieController.dispose();
    _textController.dispose();
    //_audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelSnow,
      body: AnimatedOpacity(
        opacity: _fadeOut ? 0.0 : 1.0,
        duration: const Duration(seconds: 7),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.pastelYellow, AppColors.limeStoned],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Custom logo
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(AssetsImg.logo),
                ),
                const SizedBox(height: 20),
                // Lottie animation
                Lottie.asset(
                  'assets/animation/loading.json',
                  controller: _lottieController,
                  onLoaded: (composition) {
                    _lottieController
                      ..duration = composition.duration
                      ..repeat(); // Looping
                  },
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.6,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 24),
                AnimatedBuilder(
                  animation: _textAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, -_textAnimation.value),
                      child: child,
                    );
                  },
                  child: Text(
                    'app_title'.tr,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
