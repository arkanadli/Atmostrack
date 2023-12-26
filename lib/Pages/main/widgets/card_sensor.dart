import 'package:atmostrack/Model/sensor.dart';
import 'package:flutter/material.dart';

class CardSensor extends StatelessWidget {
  const CardSensor({
    super.key,
    required this.nama,
    required this.value,
    required this.icon,
  });

  final String nama;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Theme.of(context).primaryColor.withAlpha(232),
                ),
              ],
            ),
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          nama,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
