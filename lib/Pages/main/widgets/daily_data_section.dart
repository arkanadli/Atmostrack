import 'package:atmostrack/Core/Helper%20Function/calculateAQI.dart';
import 'package:atmostrack/Core/Mqtt%20Handler/mqtt_handler.dart';
import 'package:atmostrack/Model/sensor.dart';
import 'package:atmostrack/Pages/main/widgets/detail_data_sensor_list.dart';
import 'package:flutter/material.dart';

class dailyDataSection extends StatelessWidget {
  const dailyDataSection({
    super.key,
    required this.mqttHandler,
  });

  final MqttHandler mqttHandler;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: mqttHandler.data,
      builder: (BuildContext context, String value, Widget? child) {
        if (value.isNotEmpty) {
          final data = SensorModel.fromString(value);
          final indeksAQI = hitungAQIIndex(data);
          // const indeksAQI = 2542;
          // print(indeksAQI);
          // print(data);
          // final jsonDecoded = jsonDecode(value);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Kualitas Udara Sekitar',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(400),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                      border: Border.all(
                          width: 4,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: getAqiColor(
                            indeksAQI,
                          )),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          getAqiIcon(indeksAQI),
                          size: 100,
                          color: getAqiColor(indeksAQI),
                        ),
                        Text(
                          '$indeksAQI',
                          style: TextStyle(
                            color: getAqiColor(indeksAQI),
                            fontWeight: FontWeight.w600,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kategori : ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(500),
                          ),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.1),
                        ),
                        child: Text(
                          getAqiCategory(indeksAQI),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: getAqiColor(indeksAQI),
                            // color: Color(0xFF823D6C),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      getAqiRecommendation(indeksAQI),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DetailDataSensorList(data: data),
            ],
          );
        }
        return const SizedBox(
          height: 200,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 60,
                color: Colors.orange, // You can customize the color
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Device Current status is Offline',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'No data realtime will be displayed.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          )),
        );
      },
    );
  }
}
