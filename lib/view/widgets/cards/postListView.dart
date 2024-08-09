import 'package:capstonedesign/model/cardForm.dart';
import 'package:capstonedesign/view/widgets/cards/postCard.dart';
import 'package:flutter/material.dart';

class PostListView extends StatelessWidget {
  final List<CardForm> cardForms;
  const PostListView({Key? key, required this.cardForms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: PageView.builder(
        itemCount: cardForms.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65, // Adjust width to be 85% of the screen width
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
                color: Colors.purple
              ),
              child: PostCard(cardForm: cardForms[index]),
            ),
          );
        },
        scrollDirection: Axis.horizontal, // Horizontal scroll
      ),
    );
  }
}