import 'package:flutter/material.dart';

class NoDataScreens extends StatelessWidget {
  const NoDataScreens({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 400,
      child: Center(
          child: Text('No data available..')),
    );
  }
}


