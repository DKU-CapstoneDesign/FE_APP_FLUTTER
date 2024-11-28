import 'package:capstonedesign/model/discover_sight.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/discover_festival.dart';

class DiscoverSightDetailPage extends StatefulWidget {
  final DiscoverSight discover;

  const DiscoverSightDetailPage({
    Key? key,
    required this.discover,
  }) : super(key: key);

  @override
  State<DiscoverSightDetailPage> createState() => _DiscoverDetailPageState();
}

class _DiscoverDetailPageState extends State<DiscoverSightDetailPage> {

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


              // 위치
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
                      widget.discover.address,
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
              const SizedBox(height: 15),

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


              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              ),
              const SizedBox(height: 20),

              // 설명
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  widget.discover.detail_info,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'Sejonghospital',
                    color: Colors.black87,
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