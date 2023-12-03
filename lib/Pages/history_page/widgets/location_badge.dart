import 'package:flutter/material.dart';

class LocationBadge extends StatelessWidget {
  const LocationBadge({
    super.key,
    required this.location,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 12,
      left: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 119, 87, 124),
              Color.fromARGB(255, 230, 143, 210),
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(
              color: const Color.fromARGB(255, 85, 65, 91), width: 2),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            Text(
              location,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            )
          ],
        ),
      ),
    );
  }
}
