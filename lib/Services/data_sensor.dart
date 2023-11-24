import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  final CollectionReference dataSensor =
      FirebaseFirestore.instance.collection('Data Sensor');

  final CollectionReference overallQuality =
      FirebaseFirestore.instance.collection('Overall Quality');

  Stream<QuerySnapshot> getDataSensor() {
    final dataSensorStream = dataSensor.snapshots();
    return dataSensorStream;
  }

  Stream<QuerySnapshot> getOverallQuality() {
    final dataOverallQuality =
        overallQuality.orderBy('timestamp', descending: false).snapshots();
    return dataOverallQuality;
  }

  // READ: get notes from database
  Stream<QuerySnapshot> getDataSensorStream(String targetTimestamp) {
    // Parse targetTimestamp menjadi objek DateTime
    DateTime parsedTargetTimestamp = DateTime.parse(targetTimestamp);

    // Ubah DateTime menjadi tanggal tanpa jam, menit, detik
    DateTime targetDate = DateTime(parsedTargetTimestamp.year,
        parsedTargetTimestamp.month, parsedTargetTimestamp.day);

    // Query menggunakan tanggal
    final dataSensorStream = dataSensor
        .where('timestamp',
            isGreaterThanOrEqualTo: targetDate.millisecondsSinceEpoch)
        .where('timestamp',
            isLessThan:
                targetDate.add(const Duration(days: 1)).millisecondsSinceEpoch)
        .snapshots();

    return dataSensorStream;
  }
}
