import 'package:atmostrack/Model/sensor.dart';
import 'package:flutter/material.dart';

int calculateAQIIndex(SensorModel sensorData) {
  // Define the breakpoints and corresponding AQI ranges
  const List<int> breakpoints = [0, 50, 100, 150, 200, 300, 5000];
  const List<int> aqiRanges = [0, 50, 100, 150, 200, 300, 1000];

  // Calculate AQI for each pollutant (PM2.5, PM10, CO2, etc.)
  final List<int> pollutants = [
    sensorData.pm2_5,
    // sensorData.pm10,
    sensorData.pm1_0,
    // sensorData.co2,
    // sensorData.metana
    // Add other pollutants as needed
  ];

  // Calculate the AQI for each pollutant
  final List<int> aqiValues = [];
  for (int pollutant in pollutants) {
    int i = 0;
    while (i < breakpoints.length - 1 && pollutant > breakpoints[i + 1]) {
      i++;
    }

    // Linear interpolation formula to calculate AQI
    final double aqi = ((aqiRanges[i + 1] - aqiRanges[i]) /
                (breakpoints[i + 1] - breakpoints[i])) *
            (pollutant - breakpoints[i]) +
        aqiRanges[i];

    aqiValues.add(aqi.round());
  }

  // Calculate the overall AQI as the maximum of individual AQI values
  final int overallAQI = aqiValues.reduce((max, aqi) => max > aqi ? max : aqi);

  return overallAQI;
}

String getAqiCategory(int indeksAQI) {
  if (indeksAQI <= 50) {
    return 'Sangat Baik!';
  } else if (indeksAQI <= 100) {
    return 'Cukup Baik';
  } else if (indeksAQI <= 150) {
    return 'Standard';
  } else if (indeksAQI <= 200) {
    return 'Tidak Sehat';
  } else if (indeksAQI <= 300) {
    return 'Sangat Tidak Sehat';
  } else {
    return 'Berbahaya';
  }
}

IconData getAqiIcon(int indeksAQI) {
  if (indeksAQI <= 50) {
    return Icons.sentiment_very_satisfied_sharp;
  } else if (indeksAQI <= 100) {
    return Icons.sentiment_very_satisfied;
  } else if (indeksAQI <= 150) {
    return Icons.sentiment_neutral;
  } else if (indeksAQI <= 200) {
    return Icons.sentiment_very_dissatisfied;
  } else if (indeksAQI <= 300) {
    return Icons.sentiment_very_dissatisfied_rounded;
  } else {
    return Icons.warning;
  }
}

Color getAqiColor(int indeksAQI) {
  if (indeksAQI <= 50) {
    return Colors.green;
  } else if (indeksAQI <= 100) {
    return const Color.fromARGB(255, 207, 187, 0);
  } else if (indeksAQI <= 150) {
    return Colors.orange;
  } else if (indeksAQI <= 200) {
    return Colors.red;
  } else if (indeksAQI <= 300) {
    return const Color.fromARGB(255, 255, 0, 0);
  } else {
    return Colors.black;
  }
}

String getAqiRecommendation(int indeksAQI) {
  if (indeksAQI <= 50) {
    return 'Udara baik. Aman untuk kegiatan di luar!';
  } else if (indeksAQI <= 100) {
    return 'Udara cukup baik. Hati-hati bagi yang sensitif.';
  } else if (indeksAQI <= 150) {
    return 'Tidak sehat bagi kelompok tertentu. Batasi kegiatan di luar jika anak-anak atau lansia.';
  } else if (indeksAQI <= 200) {
    return 'Udara kurang sehat. Waspadai efek kesehatan, terutama bagi yang sensitif.';
  } else if (indeksAQI <= 300) {
    return 'Udara sangat tidak sehat. Batasi kegiatan di luar ruangan untuk semua orang.';
  } else {
    return 'Bahaya! Udara sangat tidak sehat. Hindari kegiatan di luar dan gunakan masker.';
  }
}
