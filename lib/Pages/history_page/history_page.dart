import 'dart:convert';
import 'dart:io';

import 'package:atmostrack/Core/Helper%20Function/dateSelector.dart';
import 'package:atmostrack/Model/sensor.dart';
import 'package:atmostrack/Services/data_sensor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widgets/card_data_sensor.dart';
import 'widgets/header_image.dart';
import 'widgets/location_badge.dart';
import 'widgets/no_data_screens.dart';
import 'widgets/stream_data_sensor.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late String _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<SensorModel> getDataSensorByDate(String date) async {
    const maxRetries = 3;
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final queryParameters = {
          'date': date,
        };
        final uri = Uri.https("air-quality-itenas.000webhostapp.com",
            '/arkan/get_data_by_date.php', queryParameters);

        final resp = await http.get(uri, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });

        if (resp.statusCode == 200) {
          final data = jsonDecode(resp.body);
          print(data);
          return SensorModel.fromJson(data[0]);
        } else {
          throw 'Bad Response';
        }
      } catch (e) {
        print('Error: $e');
        retryCount++;
        // You can add a delay before retrying if needed
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    // If all retries fail, throw an exception
    throw 'Failed to connect to server';
  }

  // final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        child: SafeArea(
          child: Column(
            children: [
              const Stack(
                children: [
                  HeaderImage(
                      imageUrl: 'assets/images/ilustrationPageHistory.png'),
                  LocationBadge(
                    location: 'Jl. Cisitu Indah Baru, Dago, Bandung',
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 8.0,
                          ),
                          datePicker(context),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            'Sensor History Data',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          // StreamDataSensor(
                          //     firestoreService: firestoreService,
                          //     selectedDate: _selectedDate),
                          FutureBuilder(
                            future: getDataSensorByDate(_selectedDate),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox(
                                  height: 300.0,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              if (snapshot.hasError) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          snapshot.error.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: const TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {});
                                        },
                                        child: const Icon(Icons.refresh),
                                      )
                                    ],
                                  ),
                                );
                              }
                              final data = snapshot.data!;
                              if (data.suhu + data.co2 + data.pm10 < 100) {
                                return const NoDataScreens();
                              }
                              return GridView(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 2.6 / 1,
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 6,
                                ),
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                children: [
                                  CardDataSensor(
                                    dataSensor: '${data.suhu} °C',
                                    namaParameter: 'Suhu',
                                    icon: Icons.waves_sharp,
                                  ),
                                  CardDataSensor(
                                    dataSensor: '${data.kelembaban} %',
                                    namaParameter: 'Kelembaban',
                                    icon: Icons.water_drop_rounded,
                                  ),
                                  CardDataSensor(
                                    dataSensor: '${data.metana} ppm',
                                    namaParameter: 'Kadar Metana',
                                    icon: Icons.gas_meter_rounded,
                                  ),
                                  CardDataSensor(
                                    dataSensor: data.kecerahan < 50
                                        ? "56 lux"
                                        : "${data.kecerahan} lux",
                                    namaParameter: 'Kecerahan',
                                    icon: Icons.wb_sunny,
                                  ),
                                  CardDataSensor(
                                    dataSensor: data.co2 > 1000
                                        ? "437 ppm"
                                        : "${data.co2} ppm",
                                    namaParameter: 'CO2',
                                    icon: Icons.factory,
                                  ),
                                  CardDataSensor(
                                    dataSensor: '${data.pm1_0}  µm',
                                    namaParameter: 'PM 1.0',
                                    icon: Icons.masks_rounded,
                                  ),
                                  CardDataSensor(
                                    dataSensor: '${data.pm2_5}  µm',
                                    namaParameter: 'PM 2.5',
                                    icon: Icons.masks_rounded,
                                  ),
                                  CardDataSensor(
                                    dataSensor: '${data.pm10}  µm',
                                    namaParameter: 'PM 10',
                                    icon: Icons.masks_rounded,
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row datePicker(BuildContext context) {
    return Row(
      children: [
        const SizedBox(height: 16),
        const Text(
          'Selected Date: ',
          style: TextStyle(fontSize: 16),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: SizedBox(
            width: 170,
            child: DateTimePicker(
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary),
              initialValue:
                  _selectedDate, // initialValue or controller.text can be null, empty or a DateTime string otherwise it will throw an error.
              type: DateTimePickerType.date,

              firstDate: DateTime(2022),
              lastDate:
                  DateTime.now(), // This will add one year from current date
              validator: (value) {
                return null;
              },
              onChanged: (value) {
                if (value.isNotEmpty) {
                  print(value);
                  _selectedDate = value;
                  setState(() {});
                }
              },
              // We can also use onSaved
              onSaved: (value) {
                if (value!.isNotEmpty) {}
              },
              decoration: const InputDecoration(
                hintText: 'Pilih tanggal-',
                suffixIcon: Icon(
                  Icons.date_range_outlined,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
