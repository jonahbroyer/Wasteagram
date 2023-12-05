import 'package:flutter/material.dart';

class QuantityDetail extends StatelessWidget {
  final int quantity;

  const QuantityDetail({super.key, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Center(
              // check if plural is necessary
              child: quantity > 1
                  ? Text('$quantity items',
                      style: const TextStyle(fontSize: 26))
                  : Text('$quantity item',
                      style: const TextStyle(fontSize: 26)),
            ),
          ),
        ),
      ],
    );
  }
}
