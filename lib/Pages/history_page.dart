import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 285,
                child: Center(
                  child:
                      Image.asset('assets/images/ilustrationPageHistory.png'),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
