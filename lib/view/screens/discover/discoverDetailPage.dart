import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewModel/discover/discoverDetailPage_viewModel.dart';
import '../../../model/discover_festival.dart';

class DiscoverDetailPage extends StatefulWidget {
  final DiscoverFestival discover;

  const DiscoverDetailPage({
    Key? key,
    required this.discover,
  }) : super(key: key);

  @override
  State<DiscoverDetailPage> createState() => _DiscoverDetailPageState();
}

class _DiscoverDetailPageState extends State<DiscoverDetailPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<DiscoverDetailViewModel>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DiscoverDetailViewModel(),
      child: Scaffold(
        appBar: AppBar(
        ),
        body: Consumer<DiscoverDetailViewModel>(
          builder: (context, viewModel, child) {
            return GestureDetector(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: const BoxDecoration(

                      ),
                      child: const Center(
                        child: Text(
                          '2024 농민학생연대활동',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        widget.discover.name,
                        style: const TextStyle(
                          fontFamily: 'Sejonghospital',
                          fontSize: 22,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    IntrinsicWidth( //country 글자 수에 따라 컨테이너의 넓이가 정해질 수 있도록
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 20.0), // 글자 좌우에 여백 주기
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(92, 67, 239, 50),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.discover.address, // BottomNavBar를 통해 전달받는 user(로그인 한 유저)의 나라를 보여줌
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'SejonghospitalBold',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        widget.discover.period,
                        style: const TextStyle(
                          fontFamily: 'Sejonghospital',
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        widget.discover.detail_info,
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'SejonghospitalLight',
                          color: Colors.black87,
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}