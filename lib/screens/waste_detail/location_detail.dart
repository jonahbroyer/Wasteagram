import 'package:flutter/material.dart';

class LocationDetail extends StatelessWidget {
  final double latitude;
  final double longitude;

  const LocationDetail(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                'Location: (${round(latitude, 4)}, ${round(longitude, 4)})',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  double round(double number, int precision) {
    return double.parse((number).toStringAsFixed(precision));
  }
}
