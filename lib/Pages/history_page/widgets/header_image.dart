import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 265,
      child: Center(
        child: Image.asset(imageUrl),
      ),
    );
  }
}
