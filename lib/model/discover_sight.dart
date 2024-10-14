class DiscoverSight {
  final String name;
  final String image_url;
  final String address;
  final String detail_info;

  DiscoverSight({
    required this.name,
    required this.image_url,
    required this.address,
    required this.detail_info,
  });

  // JSON으로부터 DiscoverSight 객체 생성
  factory DiscoverSight.fromJson(Map<String, dynamic> json) {
    return DiscoverSight(
      name: json['name'],
      image_url: json['image_url'],
      address: json['address'],
      detail_info: json['detail_info'],
    );
  }
}
