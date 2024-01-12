import 'dart:convert';

import 'package:atmostrack/Core/Helper%20Function/calculateAQI.dart';
import 'package:atmostrack/Core/Mqtt%20Handler/mqtt_handler.dart';
import 'package:atmostrack/Model/sensor.dart';
import 'package:atmostrack/Pages/main/widgets/card_sensor.dart';
import 'package:atmostrack/Services/data_sensor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'widgets/daily_data_section.dart';
import 'widgets/detail_data_sensor_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MqttHandler mqttHandler = MqttHandler();
  late List<FlSpot> listData;
  late List<DateTime> listTanggal;
  List<Color> gradientColors = [
    const Color(0xFFAC7E9D),
    const Color(0xFFAC7E9D),
  ];
  final FirestoreService firestoreService = FirestoreService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mqttHandler.connect();
    getPredict();
  }

  Future<SensorModel> getDataSensor() async {
    const maxRetries = 3;
    int retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        final res = await http.get(Uri.parse(
            'https://air-quality-itenas.000webhostapp.com/ramzi/ambil_data_.php'));

        if (res.statusCode == 200) {
          final listDataSensor = jsonDecode(res.body);
          return SensorModel.fromJson(listDataSensor.last);
        } else {
          throw 'Bad Response';
        }
      } catch (e) {
        // print('Error: $e');
        retryCount++;
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    // If all retries fail, throw an exception
    throw 'Failed to connect to server';
  }

  Future<List<SensorModel>> getData7DaysAverage() async {
    final response = await http.get(
      Uri.parse(
          'https://air-quality-itenas.000webhostapp.com/arkan/get_7_days_avg.php'),
    );

    if (response.statusCode == 200) {
      final jsonDecoded = jsonDecode(response.body) as List;
      final listDataSensorAVG = jsonDecoded
          .map(
            (e) => SensorModel.fromJson(e),
          )
          .toList();

      return listDataSensorAVG;
    } else {
      throw 'Bad Response';
    }
  }

  Future<double> getPredict() async {
    final response = await Dio().get(
        'https://air-quality-itenas.000webhostapp.com/prediksi/prediksis.php');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.data)[0]['value'];
      return double.parse(data);
    } else {
      throw "Bad Response";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      height: 190,
                      child: Center(
                        child: Image.asset(
                            'assets/images/ilustrationMainPage.png'),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      left: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 119, 87, 124),
                              Color.fromARGB(255, 230, 143, 210),
                            ],
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          border: Border.all(
                              color: const Color.fromARGB(255, 85, 65, 91),
                              width: 2),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            Text(
                              'Bandung, Indonesia',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              dataDisplay()
            ],
          ),
        ),
      ),
    );
  }

  Expanded dataDisplay() {
    return Expanded(
      child: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: LiquidPullToRefresh(
            onRefresh: getData7DaysAverage,
            child:
                // print(snapshot.data);

                SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  dailyDataSection(mqttHandler: mqttHandler),
                  const SizedBox(
                    height: 20,
                  ),
                  dividerSection(),
                  const SizedBox(
                    height: 20,
                  ),
                  chartSection(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  dividerSection(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      'Prediksi Kualitas Udara Besok',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 20),
                    ),
                  ),
                  predictionSection(),
                  const SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            )),
      ),
    );
  }

  FutureBuilder<double> predictionSection() {
    return FutureBuilder(
      future: getPredict(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
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
        final data = snapshot.data;
        print('sadsadasd $data');
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              getAqiIcon(data!.floor()),
              size: 100,
              color: getAqiColor(data.floor()),
            ),
            Text(
              '$data',
              style: TextStyle(
                color: getAqiColor(data.floor()),
                fontWeight: FontWeight.w600,
                fontSize: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    getAqiRecommendation(data.floor()),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Container dividerSection() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).primaryColor, width: 1.2)),
    );
  }

  Column chartSection() {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: Text(
            'Monitoring Indeks 7 Hari Lalu',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 20),
          ),
        ),
        FutureBuilder(
          future: getData7DaysAverage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 400),
                    child: const CircularProgressIndicator()),
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
            final listAQI = data.map((e) => hitungAQIIndex(e)).toList();
            print(listAQI);
            listData = List.generate(
              data.length,
              (index) => FlSpot(
                  index.toDouble(), double.parse(listAQI[index].toString())),
            );
            print(listData);
            listTanggal = List.generate(
              data.length,
              (index) => DateTime.parse(data[index].tanggal),
            );
            print(listTanggal);

            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 200,
                child: AspectRatio(
                  aspectRatio: 1.8,
                  child: Padding(
                      padding: const EdgeInsets.only(
                        right: 12,
                        left: 0,
                        top: 12,
                        bottom: 0,
                      ),
                      child: LineChart(mainData())),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  SizedBox displayChart() {
    return SizedBox(
      height: 200,
      child: AspectRatio(
        aspectRatio: 1.8,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 0,
            left: 0,
            top: 12,
            bottom: 0,
          ),
          child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getOverallQuality(),
              builder: (context, snapshot) {
                try {
                  if (snapshot.hasData) {
                    final overallQualityList = snapshot.data!.docs;
                    // print(overallQualityList[0]['quality']);
                    // print(overallQualityList.length);
                    listData = List.generate(
                      overallQualityList.length,
                      (index) => FlSpot(
                          index.toDouble(),
                          double.parse(
                              overallQualityList[index]['quality'].toString())),
                    );

                    listTanggal = List.generate(
                        overallQualityList.length,
                        (index) =>
                            overallQualityList[index]['timestamp'].toDate());

                    return LineChart(mainData());
                  }
                  return const Text('ss');
                } catch (e) {
                  return const Center(
                    child: SizedBox(
                        width: 50.0, // Set a fixed width
                        height: 50.0, // Set a fixed height
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        )),
                  );
                }
              }),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );

    // Konversi nilai x menjadi indeks valid untuk listTanggal
    int index = value.toInt();
    if (index >= 0 && index < listTanggal.length) {
      DateTime tanggal = listTanggal[index];
      // Dapatkan nama hari dari properti weekday
      String namaHari = getNamaHari(tanggal.weekday);

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Text(
          namaHari,
          style: style,
        ),
      );
    }

    // Jika indeks tidak valid, tampilkan teks kosong
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: const Text('', style: style),
    );
  }

  String getNamaHari(int weekday) {
    switch (weekday) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return 'Jumat';
      case 6:
        return 'Sabtu';
      case 7:
        return 'Minggu';
      default:
        return '';
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '0';
        break;
      case 50:
        text = '50';
        break;
      case 100:
        text = '100';
        break;
      case 150:
        text = '150';
      case 200:
        text = '200';
        break;
      case 250:
        text = '250';
        break;
      case 300:
        text = '300';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
            maxContentWidth: 74,
            getTooltipItems: (touchedSpots) {
              DateTime tanggal = listTanggal[touchedSpots[0].x.floor()];

              return [
                LineTooltipItem(
                  ' ${(tanggal.day)}-${(tanggal.month)}-${(tanggal.year)}         AQI : ${touchedSpots[0].y}',
                  const TextStyle(fontSize: 12),
                )
              ];
            },
            tooltipBgColor: const Color.fromARGB(255, 255, 238, 250),
            tooltipBorder: const BorderSide(color: Colors.grey, width: 2)),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 10,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color.fromARGB(135, 139, 195, 74),
            strokeWidth: 0,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 32,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color.fromARGB(255, 174, 49, 132)),
      ),
      minX: 0,
      maxX: listData.length.toDouble() - 1,
      minY: 0,
      maxY: listData
              .reduce((value, element) => value.y > element.y ? value : element)
              .y +
          30,
      lineBarsData: [
        LineChartBarData(
          spots: listData,
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.6))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
