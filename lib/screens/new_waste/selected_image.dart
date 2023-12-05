import 'dart:io';
import 'package:flutter/material.dart';

class SelectedImage extends StatelessWidget {
  final File image;

  const SelectedImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Image(
              image: FileImage(image),
            ),
          ),
        ),
      ],
    );
  }
}
