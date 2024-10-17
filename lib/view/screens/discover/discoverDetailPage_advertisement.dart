import 'package:capstonedesign/model/discover_advertisement.dart';
import 'package:flutter/material.dart';


class DiscoverAdvertisementDetailPage extends StatefulWidget {
  final DiscoverAdvertisement discover;

  const DiscoverAdvertisementDetailPage({
    Key? key,
    required this.discover,
  }) : super(key: key);

  @override
  State<DiscoverAdvertisementDetailPage> createState() => _DiscoverDetailPageState();
}

class _DiscoverDetailPageState extends State<DiscoverAdvertisementDetailPage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
        ),
        body: GestureDetector(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // 이미지
                    Image.network(
                      widget.discover.image_url,
                      height: 350.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 30),

                    // 이름
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        widget.discover.name,
                        style: const TextStyle(
                          fontFamily: 'SejonghospitalBold',
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),


                    // 가격
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: IntrinsicWidth(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(92, 67, 239, 50),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            widget.discover.price,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'SejonghospitalBold',
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
    );
  }
}