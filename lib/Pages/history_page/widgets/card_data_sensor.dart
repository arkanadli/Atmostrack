import 'package:flutter/material.dart';

class CardDataSensor extends StatelessWidget {
  const CardDataSensor({
    super.key,
    required this.dataSensor,
    required this.namaParameter,
  });

  final String dataSensor;
  final String namaParameter;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 8,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(dataSensor),
                Text('AVG', style: Theme.of(context).textTheme.labelSmall)
              ],
            ),
          ),
          Container(
            width: 1.0,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Colors.grey[400]!,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(namaParameter,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.labelSmall),
                  Text(
                    'Sangat Baik',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
