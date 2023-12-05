import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageDetail extends StatelessWidget {
  final String photoURL;

  const ImageDetail({super.key, required this.photoURL});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            // https://pub.dev/packages/cached_network_image
            // to show images and keep them cached
            child: CachedNetworkImage(
              imageUrl: photoURL,
              placeholder: (context, url) => const Padding(
                padding: EdgeInsets.all(100),
                child: Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueGrey)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
