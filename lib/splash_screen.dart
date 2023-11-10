import 'package:atmostrack/Pages/main_boilerplate.dart';
import 'package:atmostrack/Pages/main_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    _loadingScreen();
    super.initState();
  }

  _loadingScreen() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainBoilerPlate()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            const Spacer(),
            Container(
              child: Image.asset('assets/images/landingPage.png'),
            ),
            const Spacer(),
            SizedBox(
              width: double.maxFinite,
              child: Text(
                'ATMOSTRACK',
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
