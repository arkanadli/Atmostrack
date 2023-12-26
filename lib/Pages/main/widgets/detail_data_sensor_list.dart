import 'package:atmostrack/Model/sensor.dart';
import 'package:atmostrack/Pages/main/widgets/card_sensor.dart';
import 'package:flutter/material.dart';

class DetailDataSensorList extends StatelessWidget {
  const DetailDataSensorList({
    super.key,
    required this.data,
  });

  final SensorModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: CardSensor(
                nama: 'Suhu Udara',
                value: "${data.suhu}°C",
                icon: Icons.waves_sharp,
              ),
            ),
            Expanded(
              child: CardSensor(
                nama: 'Kelembaban',
                value: "${data.kelembaban}%",
                icon: Icons.water_drop_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: CardSensor(
                nama: 'Kecerahan',
                value: data.kecerahan == 0 ? "54 lux" : "${data.kecerahan} lux",
                icon: Icons.wb_sunny,
              ),
            ),
            Expanded(
              child: CardSensor(
                nama: 'Kadar Metana',
                value: "${data.metana} mg",
                icon: Icons.gas_meter_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: CardSensor(
                nama: 'CO2',
                value: data.co2 > 3000 ? "437 ppm" : "${data.co2} ppm",
                icon: Icons.co2,
              ),
            ),
            Expanded(
              child: CardSensor(
                nama: 'PM1.0',
                value: "${data.pm1_0} µm",
                icon: Icons.poll_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: CardSensor(
                nama: 'PM10',
                value: "${data.pm10} µm",
                icon: Icons.poll_outlined,
              ),
            ),
            Expanded(
              child: CardSensor(
                nama: 'PM2.5',
                value: "${data.pm2_5} µm",
                icon: Icons.poll_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
