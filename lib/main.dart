import 'package:atmostrack/splash_screen.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const AtmostrackApp());
}

class AtmostrackApp extends StatelessWidget {
  const AtmostrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.purpleAccent,
            primary: const Color(0xFF823D6C),
            secondary: const Color(0xFFAC7E9D),
            inversePrimary: const Color(0xFF1A0C16)),
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
            headlineLarge: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 32,
              fontWeight: FontWeight.w200,
              color: Color(0xFF823D6C),
            ),
            bodyMedium: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: Color(0xFF823D6C),
            )),
      ),
      home: const SplashScreen(),
    );
  }
}
