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
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
        child: ListView.builder(
          itemCount: cardForms.length,
          itemBuilder: (context, index) {
            return PostCard(cardForm: cardForms[index]);
          },
          scrollDirection: Axis.horizontal, // 가로 스크롤
        ),
      );
  }
}
