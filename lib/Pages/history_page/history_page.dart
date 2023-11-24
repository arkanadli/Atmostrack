import 'package:atmostrack/Services/data_sensor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'widgets/card_data_sensor.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _selectedDate = DateTime.now().toString();

  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    height: 265,
                    child: Center(
                      child: Image.asset(
                          'assets/images/ilustrationPageHistory.png'),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
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
                          Row(
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    initialValue:
                                        _selectedDate, // initialValue or controller.text can be null, empty or a DateTime string otherwise it will throw an error.
                                    type: DateTimePickerType.date,

                                    firstDate: DateTime(2022),
                                    lastDate: DateTime
                                        .now(), // This will add one year from current date
                                    validator: (value) {
                                      return null;
                                    },
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          _selectedDate = value;
                                        });
                                      }
                                    },
                                    // We can also use onSaved
                                    onSaved: (value) {
                                      if (value!.isNotEmpty) {
                                        _selectedDate = value;
                                      }
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
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: firestoreService.getDataSensor(),
                              builder: (context, snapshot) {
                                // QueryDocumentSnapshot dataEqualToDate;
                                try {
                                  if (snapshot.hasData) {
                                    final dataSensorList = snapshot.data!.docs;
                                    List<Map<String, dynamic>>
                                        dataSesuaiTanggal = filterDataByDate(
                                            dataSensorList, _selectedDate);
                                    // print(dataSesuaiTanggal);

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
                                          dataSensor:
                                              '${dataSesuaiTanggal[0]['kelembaban']}%',
                                          namaParameter: 'Kelembaban',
                                        ),
                                        CardDataSensor(
                                          dataSensor:
                                              '${dataSesuaiTanggal[0]["metana"]}ppm',
                                          namaParameter: 'Kadar Metana',
                                        ),
                                        CardDataSensor(
                                          dataSensor:
                                              '${dataSesuaiTanggal[0]['suhu']}°C',
                                          namaParameter: 'Suhu',
                                        ),
                                      ],
                                    );
                                  }
                                  return const Text('Loading...');
                                } catch (e) {
                                  return const SizedBox(
                                    height: 400,
                                    child: Center(
                                        child: Text('No data available..')),
                                  );
                                }
                              }),
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
}

// Fungsi untuk menyaring data berdasarkan tanggal
List<Map<String, dynamic>> filterDataByDate(
    List<DocumentSnapshot> dataSensorList, String selectedDate) {
  // Ambil DateTime dari selectedDate (yang diasumsikan sebagai string)
  DateTime dateTime = DateTime.parse(selectedDate);

  // List untuk menyimpan data yang sesuai dengan tanggal
  List<Map<String, dynamic>> dataSesuaiTanggal = [];

  // Loop melalui semua elemen di dataSensorList
  for (var data in dataSensorList) {
    // Ambil Timestamp dari data
    Timestamp waktu = data['timestamp'];

    // Ubah Timestamp menjadi objek DateTime
    DateTime date = waktu.toDate();

    // Periksa tahun, bulan, dan tanggal
    if (dateTime.year == date.year &&
        dateTime.month == date.month &&
        dateTime.day == date.day) {
      // Jika tanggal sesuai, tambahkan data ke list
      dataSesuaiTanggal.add(data.data() as Map<String, dynamic>);
    }
  }

  return dataSesuaiTanggal;
}
