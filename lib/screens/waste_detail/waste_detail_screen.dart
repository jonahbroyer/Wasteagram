import 'package:flutter/material.dart';
import '../../models/food_waste_post.dart';
import 'date_detail.dart';
import 'image_detail.dart';
import 'location_detail.dart';
import 'quantity_detail.dart';

class WasteDetailScreen extends StatelessWidget {
  FoodWastePost post;

  WasteDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    post = ModalRoute.of(context)!.settings.arguments as FoodWastePost;
    return Scaffold(
      appBar: AppBar(title: const Text('Wasteagram'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView(
            children: [
              Column(
                children: [
                  DateDetail(date: post.date),
                  ImageDetail(photoURL: post.photoURL),
                  QuantityDetail(quantity: post.quantity),
                  LocationDetail(
                      latitude: post.latitude, longitude: post.longitude)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
