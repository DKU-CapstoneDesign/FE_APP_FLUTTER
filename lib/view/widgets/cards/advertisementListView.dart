import 'package:capstonedesign/model/advertisementForm.dart';
import 'package:capstonedesign/view/widgets/cards/advertisementCard.dart';
import 'package:flutter/material.dart';


class AdvertisementListView extends StatelessWidget {
  final List<AdvertisementForm> advertisementForms;
  const AdvertisementListView({Key? key, required this.advertisementForms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.48,
      ),
      child: PageView.builder(
        itemCount: advertisementForms.length,
        itemBuilder: (context, index) {
          return AdvertisementCard(advertisementForm: advertisementForms[index]);
        },
        scrollDirection: Axis.horizontal, // 가로 스크롤
      ),
    );
  }
}
