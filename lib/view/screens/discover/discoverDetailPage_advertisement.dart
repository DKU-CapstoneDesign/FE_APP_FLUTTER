import 'package:capstonedesign/model/discover_advertisement.dart';
import 'package:flutter/material.dart';
import '../../../model/translate/translationService.dart';

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
  final TranslationService _translationService = TranslationService(); // 번역 서비스 인스턴스
  bool _isTranslating = false; // 번역 로딩 상태
  String _translatedName = ""; // 번역된 이름 저장
  String _translatedPrice = ""; // 번역된 가격 저장

  @override
  void initState() {
    super.initState();
    _fetchTranslatedData('ko'); // 초기 언어는 한국어
  }

  Future<void> _fetchTranslatedData(String language) async {
    setState(() {
      _isTranslating = true;
    });

    try {
      // 이름 번역
      final translatedName = await _translationService.translate(widget.discover.name, language);
      // 가격 번역
      final translatedPrice = await _translationService.translate('${widget.discover.price} ₩', language);

      setState(() {
        _translatedName = translatedName;
        _translatedPrice = translatedPrice;
      });
    } catch (e) {
      // 에러 처리
      setState(() {
        _translatedName = "번역 실패";
        _translatedPrice = "번역 실패";
      });
    } finally {
      setState(() {
        _isTranslating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // 언어 변경 버튼
          PopupMenuButton<String>(
            onSelected: (String language) {
              _fetchTranslatedData(language); // 언어 선택 시 번역
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'ko', child: Text('한국어')),
              const PopupMenuItem(value: 'en', child: Text('English')),
            ],
          ),
        ],
      ),
      body: _isTranslating
          ? const Center(child: CircularProgressIndicator()) // 번역 중 로딩 표시
          : GestureDetector(
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

              // 번역된 이름
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  _translatedName, // 번역된 이름 표시
                  style: const TextStyle(
                    fontFamily: 'SejonghospitalBold',
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // 번역된 가격
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
                      _translatedPrice, // 번역된 가격 표시
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
