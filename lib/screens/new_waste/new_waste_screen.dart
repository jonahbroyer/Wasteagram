import 'dart:io';
import 'package:flutter/material.dart';
import 'add_post_form.dart';

class NewWasteScreen extends StatelessWidget {
  File image;

  NewWasteScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    image = ModalRoute.of(context)!.settings.arguments as File;
    return Scaffold(
      appBar: AppBar(title: const Text('New Post'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: AddPostForm(image: image),
        ),
      ),
    );
  }
}
