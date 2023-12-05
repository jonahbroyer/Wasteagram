import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'post_list.dart';

class WasteListScreen extends StatefulWidget {
  const WasteListScreen({super.key});

  @override
  State<WasteListScreen> createState() => _WasteListScreenState();
}

class _WasteListScreenState extends State<WasteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, snapshot) => totalWaste(context, snapshot),
            ),
            centerTitle: true),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: PostList(),
          ),
        ),
        floatingActionButton: Semantics(
          button: true,
          enabled: true,
          onTapHint: 'Add Post',
          // https://pub.dev/packages/flutter_speed_dial
          // fancy popup for fab's
          child: SpeedDial(
            childMargin: const EdgeInsets.all(8.0),
            children: [
              SpeedDialChild(
                child: Semantics(
                  button: true,
                  enabled: true,
                  onTapHint: 'Take Photo',
                  child: const Icon(Icons.camera_alt),
                ),
                backgroundColor: Colors.blue,
                label: 'Camera',
                labelStyle: const TextStyle(fontSize: 18),
                onTap: () => getImageFromCamera(),
              ),
              SpeedDialChild(
                child: Semantics(
                    button: true,
                    enabled: true,
                    onTapHint: 'Choose From Gallery',
                    child: const Icon(Icons.photo_album)),
                backgroundColor: Colors.green,
                label: 'Gallery',
                labelStyle: const TextStyle(fontSize: 18),
                onTap: () => getImageFromGallery(),
              ),
            ],
            child: const Icon(Icons.add),
          ),
        ));
  }

  // Extra credit
  Widget totalWaste(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
      int sum = 0;
      for (var post in snapshot.data!.docs) {
        sum += post['quantity'] as int;
      }
      return Text('Wasteagram - $sum');
    } else {
      return const Text('Wasteagram - 0');
    }
  }

  Future getImageFromCamera() async {
    File? image;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    image = File(pickedFile!.path);
    Navigator.of(context).pushNamed('new', arguments: image);
  }

  Future getImageFromGallery() async {
    File? image;
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    Navigator.of(context).pushNamed('new', arguments: image);
  }
}
