import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/food_waste_post.dart';
import 'post_list_tile.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Column(children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) =>
                  convertEntriesToListTiles(context, snapshot),
            ),
          ),
        ]));
  }

  Widget convertEntriesToListTiles(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
      return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var postData = snapshot.data!.docs[index];
            FoodWastePost post = createPostFromMap(postData);
            return PostListTile(post: post);
          });
    }
    return const Center(
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)));
  }

  // https://stackoverflow.com/questions/64949640/flutter-unhandled-exception-bad-state-field-does-not-exist-within-the-documen
  FoodWastePost createPostFromMap(DocumentSnapshot post) {
    return FoodWastePost(
      // id: post['id'],
      date: post['date'].toDate(),
      // photoURL: post['photoURL'],
      // quantity: post['quantity'],
      // latitude: post['latitude'],
      // longitude: post['longitude'],
      id: post.data().toString().contains('id') ? post.get('id') : '',
      //date: post.data().toString().contains('date') ? post.get('date') : DateTime.now(),
      photoURL: post.data().toString().contains('photoURL')
          ? post.get('photoURL')
          : '',
      quantity: post.data().toString().contains('quantity')
          ? post.get('quantity')
          : 0,
      latitude: post.data().toString().contains('latitude')
          ? post.get('latitude')
          : 0.0,
      longitude: post.data().toString().contains('longitude')
          ? post.get('longitude')
          : 0.0,
    );
  }
}
