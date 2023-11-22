import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreDataSensor {
  final CollectionReference dataSensor =
      FirebaseFirestore.instance.collection('Data Sensor');

  // READ : get notes from database
  Stream<QuerySnapshot> getDataSensorStream() {
    final dataSensorStream =
        dataSensor.orderBy('timestamp', descending: true).snapshots();

    return dataSensorStream;
  }
}
