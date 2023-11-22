import 'package:atmostrack/Pages/history_page/history_page.dart';
import 'package:atmostrack/Pages/main/main_page.dart';
import 'package:atmostrack/Pages/profile_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainBoilerPlate extends StatefulWidget {
  const MainBoilerPlate({super.key});

  @override
  State<MainBoilerPlate> createState() => MainBoilerPlateState();
}

class MainBoilerPlateState extends State<MainBoilerPlate> {
  int currentPage = 0;
  List<Widget> listFragment = const [
    MainPage(),
    HistoryPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: listFragment,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: currentPage,
        height: 75,
        backgroundColor: currentPage == 2
            ? Theme.of(context).colorScheme.inversePrimary
            : Colors.transparent,
        color: Theme.of(context).colorScheme.primary,
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.ease,
        buttonBackgroundColor: Theme.of(context).colorScheme.primary,
        items: const <Widget>[
          Icon(
            // Icons.filter_hdr_sharp,
            Icons.home_filled,
            size: 30,
            color: Color.fromARGB(255, 238, 238, 238),
          ),
          Icon(
            Icons.history,
            size: 30,
            color: Color.fromARGB(255, 238, 238, 238),
          ),
          Icon(
            Icons.info_rounded,
            size: 30,
            color: Color.fromARGB(255, 238, 238, 238),
          )
        ],
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
          // print(currentPage);
        },
      ),
    );
  }
}
