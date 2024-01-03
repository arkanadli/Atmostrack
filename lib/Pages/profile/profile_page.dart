import 'package:flutter/material.dart';

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
                    const Text(
                      'Air Quality Monitoring Devices',
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
                          image: NetworkImage(
                            "https://images.unsplash.com/photo-1533050487297-09b450131914?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
                          ),
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
                      "Members",
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
                          CardAnggota(
                            nama: 'Muhammad Arkan A.',
                            nrp: '152021168',
                            umur: '20',
                            imgUrl: 'assets/images/fotoarkan.png',
                          ),
                          CardAnggota(
                            nama: 'Muhammad Arkan A.',
                            nrp: '152021168',
                            umur: '20',
                            imgUrl: 'assets/images/fotoarkan.png',
                          ),
                          CardAnggota(
                            nama: 'Muhammad Arkan A.',
                            nrp: '152021168',
                            umur: '20',
                            imgUrl: 'assets/images/fotoarkan.png',
                          ),
                          CardAnggota(
                            nama: 'Muhammad Arkan A.',
                            nrp: '152021168',
                            umur: '20',
                            imgUrl: 'assets/images/fotoarkan.png',
                          ),
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

class CardAnggota extends StatelessWidget {
  const CardAnggota({
    super.key,
    required this.nama,
    required this.umur,
    required this.nrp,
    required this.imgUrl,
  });

  final String nama;
  final String umur;
  final String nrp;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 51, 23, 43),
          border: Border.all(color: Colors.purple, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(105, 255, 130, 240),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: [
          Container(
            width: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgUrl), fit: BoxFit.cover),
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(16))),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '$umur Years old',
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      color: Colors.white70),
                ),
                Text(
                  nrp,
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      color: Colors.white70),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
