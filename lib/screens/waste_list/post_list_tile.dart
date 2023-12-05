import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/food_waste_post.dart';

DateFormat dateFormat = DateFormat('EEEE, LLL. d');

class PostListTile extends StatelessWidget {
  final FoodWastePost post;

  const PostListTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      onTapHint: 'View Post# ${post.id}',
      child: ListTile(
        title: Text(
          dateFormat.format(post.date),
          style: const TextStyle(fontSize: 22),
        ),
        trailing: Container(
          decoration: const ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Text(
              post.quantity.toString(),
              style: const TextStyle(fontSize: 22),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed('detail', arguments: post);
        },
      ),
    );
  }
}
