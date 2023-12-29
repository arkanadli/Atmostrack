import 'package:atmostrack/Core/Helper%20Function/dateSelector.dart';
import 'package:atmostrack/Pages/history_page/widgets/card_data_sensor.dart';
import 'package:atmostrack/Pages/history_page/widgets/no_data_screens.dart';
import 'package:atmostrack/Services/data_sensor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StreamDataSensor extends StatelessWidget {
  const StreamDataSensor({
    super.key,
    required this.firestoreService,
    required String selectedDate,
  }) : _selectedDate = selectedDate;

  final FirestoreService firestoreService;
  final String _selectedDate;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getDataSensor(),
        builder: (context, snapshot) {
          // QueryDocumentSnapshot dataEqualToDate;
          try {
            if (snapshot.hasData) {
              final dataSensorList = snapshot.data!.docs;
              List<Map<String, dynamic>> dataSesuaiTanggal =
                  filterDataByDate(dataSensorList, _selectedDate);
              // print(dataSesuaiTanggal);

              return GridView(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2.6 / 1,
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 6,
                ),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: [
                  CardDataSensor(
                    dataSensor: '${dataSesuaiTanggal[0]['kelembaban']}%',
                    namaParameter: 'Kelembaban',
                    icon: Icons.water_drop_outlined,
                  ),
                ],
              );
            }
            return const Text('Loading...');
          } catch (e) {
            return const NoDataScreens();
          }
        });
  }
}
