import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'selected_image.dart';

class AddPostForm extends StatefulWidget {
  final File image;

  const AddPostForm({super.key, required this.image});

  @override
  State<AddPostForm> createState() => _AddPostFormState();
}

class _AddPostFormState extends State<AddPostForm> {
  final formKey = GlobalKey<FormState>();

  late LocationData locationData;

  late int quantity;
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Column(
            children: [
              SelectedImage(image: widget.image),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 10),
                      child: Semantics(
                        textField: true,
                        focusable: true,
                        child: TextFormField(
                            autofocus: true,
                            decoration: const InputDecoration(
                              labelText: 'Number of Wasted Items',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onSaved: (value) {
                              quantity = int.parse(value!);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the number of items';
                              }
                              return null;
                            }),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Semantics(
                        button: true,
                        enabled: true,
                        onTapHint: 'Upload Post',
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              buttonPressed = true;
                              setState(() {});
                              uploadPost();
                              Navigator.of(context).pop();
                            }
                            Colors.lightBlue;
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 80),
                            child: Center(
                              child: FutureBuilder(
                                future: retrieveLocation(),
                                builder: (context, snapshot) =>
                                    showButtonOrLoading(context, snapshot),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget showButtonOrLoading(
      BuildContext context, AsyncSnapshot<LocationData> snapshot) {
    if (snapshot.hasData) {
      locationData = snapshot.data!;
      if (!buttonPressed) {
        return const Icon(Icons.cloud_upload, size: 50, color: Colors.white);
      }
    }
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)),
    );
  }

  void uploadPost() async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('${getFilename()} (${DateTime.now()})');
    UploadTask uploadTask = storageReference.putFile(widget.image);
    await uploadTask;
    String url = await storageReference.getDownloadURL();
    FirebaseFirestore.instance.collection('posts').add({
      'date': Timestamp.fromDate(DateTime.now()),
      'photoURL': url,
      'latitude': locationData.latitude,
      'longitude': locationData.longitude,
      'quantity': quantity,
    });
  }

  String getFilename() {
    int lastSlashIndex = widget.image.path.lastIndexOf('/');
    return widget.image.path.substring(lastSlashIndex);
  }

  Future<LocationData> retrieveLocation() async {
    Location location = Location();
    return await location.getLocation();
  }
}
