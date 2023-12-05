import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat('EEEE, LLL. d yyyy');

class DateDetail extends StatelessWidget {
  final DateTime date;

  const DateDetail({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                dateFormat.format(date),
                style: const TextStyle(fontSize: 26),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
