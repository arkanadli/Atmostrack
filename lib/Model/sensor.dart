import 'package:equatable/equatable.dart';

class SensorModel extends Equatable {
  final String id;
  final int suhu;
  final int kelembaban;
  final int kecerahan;
  final String tanggal;
  final int metana;
  final int pm1_0;
  final int pm2_5;
  final int pm10;
  final int co2;

  const SensorModel({
    required this.id,
    required this.suhu,
    required this.kelembaban,
    required this.kecerahan,
    required this.tanggal,
    required this.metana,
    required this.pm1_0,
    required this.pm2_5,
    required this.pm10,
    required this.co2,
  });

  factory SensorModel.fromJson(Map<String, dynamic> json) {
    return SensorModel(
      id: json['id'],
      suhu: json['suhu'],
      kelembaban: json['kelembaban'],
      kecerahan: json['kecerahan'],
      tanggal: json['tanggal'],
      metana: json['metana'],
      pm1_0: json['pm1_0'],
      pm2_5: json['pm2_5'],
      pm10: json['pm10'],
      co2: json['co2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'suhu': suhu,
      'kelembaban': kelembaban,
      'kecerahan': kecerahan,
      'tanggal': tanggal,
      'metana': metana,
      'pm1_0': pm1_0,
      'pm2_5': pm2_5,
      'pm10': pm10,
      'co2': co2,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        suhu,
        kelembaban,
        kecerahan,
        tanggal,
        metana,
        pm1_0,
        pm2_5,
        pm10,
        co2,
      ];
}
