import 'package:flutter/material.dart';

class CardDataSensor extends StatelessWidget {
  const CardDataSensor({
    super.key,
    required this.dataSensor,
    required this.namaParameter,
    required this.icon,
  });

  final String dataSensor;
  final String namaParameter;
  final IconData icon;

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
            flex: 7,
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
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    namaParameter,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
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
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(dataSensor),
                const SizedBox(
                  height: 8.0,
                ),
                Text('Rata-Rata', style: Theme.of(context).textTheme.labelSmall)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
