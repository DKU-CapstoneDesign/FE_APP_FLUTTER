import 'package:capstonedesign/model/advertisementForm.dart';
import 'package:capstonedesign/model/cardForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../screens/discover/discoverDetailPage.dart';



class AdvertisementCard extends StatelessWidget {
  final AdvertisementForm advertisementForm;
  const AdvertisementCard({Key? key, required this.advertisementForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: GestureDetector(
        onTap: () {
          print("post clicked!!!");
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => DiscoverDetailPage(cardForm: this.cardForm,)));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.network(
                    advertisementForm.imageUrl,
                    height: MediaQuery.of(context).size.height * 0.28,
                  )
                ),
                SizedBox(height: 16.0),
                Text(
                  advertisementForm.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  advertisementForm.price + '₩',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                )
                // SizedBox(height: 8.0),
                // Text(post.content),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
