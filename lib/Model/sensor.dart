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
      id: json['id'] ?? 'sad',
      suhu: int.parse(json['suhu']),
      kelembaban: int.parse(json['kelembaban']),
      kecerahan: int.parse(json['kecerahan']),
      tanggal: json['tanggal'] ?? '2023-12-24',
      metana: int.parse(json['metana']),
      pm1_0: int.parse(json['pm1_0']),
      pm2_5: int.parse(json['pm2_5']),
      pm10: int.parse(json['pm10']),
      co2: int.parse(json['co2']),
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
