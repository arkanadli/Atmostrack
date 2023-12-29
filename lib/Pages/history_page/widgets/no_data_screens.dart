import 'package:flutter/material.dart';

class NoDataScreens extends StatelessWidget {
  const NoDataScreens({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber,
            size: 40,
            color: Colors.orange, // You can customize the color
          ),
          Text(
            'No data available',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Please Select Another Date to be Displayed!',
            style: TextStyle(fontSize: 14),
          ),
        ],
      )),
    );
  }
}
