import 'package:atmostrack/Services/data_sensor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
                      height: 265,
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
                              'Jl. Cisitu Indah Baru, Dago, Bandung',
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
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            'Your Air Quality Stats',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        SizedBox(
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
                                        final overallQualityList =
                                            snapshot.data!.docs;
                                        // print(overallQualityList[0]['quality']);
                                        // print(overallQualityList.length);
                                        listData = List.generate(
                                          overallQualityList.length,
                                          (index) => FlSpot(
                                              index.toDouble(),
                                              double.parse(
                                                  overallQualityList[index]
                                                          ['quality']
                                                      .toString())),
                                        );

                                        listTanggal = List.generate(
                                            overallQualityList.length,
                                            (index) => overallQualityList[index]
                                                    ['timestamp']
                                                .toDate());

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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 1.2)),
                        ),
                        const SizedBox(
                          height: 20,
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Text(
                            'Kualitas Harian Sangat Baik!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).colorScheme.inversePrimary
                                // color: Color(0xFF823D6C),
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '96%',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const Text(
                                  'Kadar Oksigen',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '125mg',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const Text(
                                  'Kadar Metana',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '20%',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const Text(
                                  'Kelembaban',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                      ],
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      // case 0:
      //   text = const Text('SEP', style: style);
      //   break;
      // case 4:
      //   text = const Text('OCT', style: style);
      //   break;
      // case 8:
      //   text = const Text('NOV', style: style);
      //   break;
      // case 12:
      //   text = const Text('Desember', style: style);
      //   break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '0%';
        break;
      case 50:
        text = '50%';
        break;
      case 98:
        text = '100%';
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
            maxContentWidth: 90,
            getTooltipItems: (touchedSpots) {
              DateTime tanggal = listTanggal[touchedSpots[0].x.floor()];

              return [
                LineTooltipItem(
                  ' ${(tanggal.day)}-${(tanggal.month)}-${(tanggal.year)}   %${touchedSpots[0].y}',
                  const TextStyle(fontSize: 12),
                )
              ];
            },
            tooltipBgColor: Colors.white,
            tooltipBorder: const BorderSide(color: Colors.grey)),
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
      maxY: 100,
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
