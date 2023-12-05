import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'screens/new_waste/new_waste_screen.dart';
import 'screens/waste_detail/waste_detail_screen.dart';
import 'screens/waste_list/waste_list_screen.dart';

class App extends StatelessWidget {
  App({super.key});

  // mock post for constructor
  final post = FoodWastePost(
      id: '0',
      date: DateTime.parse('1969-07-20 20:18:04Z'),
      photoURL: 'tempURl',
      quantity: 3,
      latitude: 100.1,
      longitude: -199.4);

  // mock image
  final image = File('assets/cake.jpg');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(brightness: Brightness.dark),
      initialRoute: '/',
      routes: getRoutes(),
    );
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const WasteListScreen(),
      'detail': (context) => WasteDetailScreen(
            post: post,
          ),
      'new': (context) => NewWasteScreen(
            image: image,
          )
    };
  }
}
