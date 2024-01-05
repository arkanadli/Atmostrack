import 'package:flutter/material.dart';

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
