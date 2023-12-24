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
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Theme.of(context).primaryColor.withAlpha(232),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              nama,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
