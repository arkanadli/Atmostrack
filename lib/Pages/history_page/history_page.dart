import 'package:atmostrack/Core/Helper%20Function/dateSelector.dart';
import 'package:atmostrack/Services/data_sensor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

import 'widgets/card_data_sensor.dart';
import 'widgets/header_image.dart';
import 'widgets/location_badge.dart';
import 'widgets/no_data_screens.dart';
import 'widgets/stream_data_sensor.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final String _selectedDate = DateTime.now().toString();

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
                          StreamDataSensor(
                              firestoreService: firestoreService,
                              selectedDate: _selectedDate),
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
                if (value.isNotEmpty) {}
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
