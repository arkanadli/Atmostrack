import 'package:atmostrack/Pages/main_boilerplate.dart';
import 'package:atmostrack/Pages/main_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<Offset> transAnimation;

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    fadeAnimation = Tween(begin: 0.6, end: 1.00).animate(
      CurvedAnimation(parent: controller, curve: Curves.decelerate),
    );
    controller.forward();
    fadeAnimation.addListener(() {
      if (fadeAnimation.isDismissed) {
        controller.forward();
      }
      if (fadeAnimation.isCompleted) {
        controller.reverse();
      }
    });
    //
    transAnimation = Tween(
            begin: const Offset(0, -0.02), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    //

    _loadingScreen();
    super.initState();
  }

  _loadingScreen() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainBoilerPlate()),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            const Spacer(),
            FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: transAnimation,
                child: Image.asset('assets/images/landingPage.png'),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.maxFinite,
              child: Text(
                ' ATMOSTRACK ',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
