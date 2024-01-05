import 'package:flutter/material.dart';

import 'widgets/card_anggota.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.maxFinite,
          color: Theme.of(context).colorScheme.inversePrimary,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      'MEET OUR TEAM',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Text(
                      'Group Arcanery proudly present.',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 225, 225, 225),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 240.0,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/Tim_Atmostrack.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            0,
                          ),
                        ),
                        border: Border.all(color: Colors.purple, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(105, 255, 130, 240),
                            blurRadius: 8,
                            spreadRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Text(
                      'Tim Kelompok Air Quality dari Institut Teknologi Nasional Bandung Beranggotakan  : \nHanna, Farhan, Ariq, Arkan, Fadhlan, Ramzi.',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 225, 225, 225),
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Text(
                      'ATMOSTRACK',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    const Text(
                      'Aplikasi Atmostrack, merupakan aplikasi Pemantauan Kualitas Udara yang membawa pemahaman mendalam tentang kondisi udara di sekitar Anda. Dirancang untuk memberikan informasi real-time tentang berbagai parameter kualitas udara.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color.fromARGB(255, 225, 225, 225),
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      "Developer Profile",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    GridView(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 333 / 184,
                          crossAxisCount: 1,
                          mainAxisSpacing: 30,
                          crossAxisSpacing: 0,
                        ),
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        children: const [
                          CardAnggota(
                            nama: 'Muhammad Arkan A.',
                            nrp: '152021168',
                            umur: '20',
                            imgUrl: 'assets/images/fotoarkan.png',
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
