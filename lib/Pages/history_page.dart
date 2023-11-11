import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _selectedDate = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 285,
                child: Center(
                  child:
                      Image.asset('assets/images/ilustrationPageHistory.png'),
                ),
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
                                        '', // initialValue or controller.text can be null, empty or a DateTime string otherwise it will throw an error.
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
                                      suffixIcon:
                                          Icon(Icons.date_range_outlined),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 2.6 / 1,
                              crossAxisCount: 1,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 6,
                            ),
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  elevation: 8,
                                  child: Row(
                                    children: [
                                      const Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [Text('96%'), Text('AVG')],
                                        ),
                                      ),
                                      Container(
                                        width: 1.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey[400]!,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Kadar Oksigen',
                                                  textAlign: TextAlign.left,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelSmall),
                                              Text(
                                                'Sangat Baik',
                                                textAlign: TextAlign.left,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          ),
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
