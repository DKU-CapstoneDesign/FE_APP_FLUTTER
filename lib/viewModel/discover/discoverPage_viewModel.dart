import 'package:flutter/material.dart';

import '../../model/discover_sight.dart';


class DiscoverViewModel extends ChangeNotifier {
  //만약 정보를 가져오지 못했을 경우 에러를 표시함
  final List<Discover> _discoverPosts = [
    Discover(
        title: '정보를 불러오지 못했습니다.',
        content: '관리자에게 연락해주세요',
        imageUrl: "https://img.freepik.com/free-vector/error-404-concept-for-landing-page_23-2148237748.jpg?w=1380&t=st=1725265497~exp=1725266097~hmac=d7a95048d969f691ccefe06c9d42eadd35021b0542f025271d0ca609a3945969"
    ),
    Discover(
        title: '정보를 불러오지 못했습니다.',
        content: '관리자에게 연락해주세요',
        imageUrl: "https://img.freepik.com/free-vector/error-404-concept-for-landing-page_23-2148237748.jpg?w=1380&t=st=1725265497~exp=1725266097~hmac=d7a95048d969f691ccefe06c9d42eadd35021b0542f025271d0ca609a3945969"
    ),
  ];

  List<Discover> get discoverPosts => _discoverPosts;

  List<Discover> filteredDiscoverPosts(String category) {
    if (category == 'all') {
      return _discoverPosts;
    } else {
      return _discoverPosts.where((post) => post.title.toLowerCase().contains(category.toLowerCase())).toList();
    }
  }
}