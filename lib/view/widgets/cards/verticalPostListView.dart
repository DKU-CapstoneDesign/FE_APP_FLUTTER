import 'package:capstonedesign/model/cardForm.dart';
import 'package:capstonedesign/view/widgets/cards/postCard.dart';
import 'package:flutter/material.dart';


class VerticalPostListView extends StatelessWidget {
  final List<CardForm> cardForms;
  const VerticalPostListView({Key? key, required this.cardForms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: ListView.builder(
        itemCount: cardForms.length,
        itemBuilder: (context, index) {
          return PostCard(cardForm: cardForms[index]);
        },
        scrollDirection: Axis.vertical, // 세로 스크롤
      ),
    );
  }
}
