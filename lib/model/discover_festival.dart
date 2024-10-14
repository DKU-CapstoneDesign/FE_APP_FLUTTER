class DiscoverFestival {
  final String name;
  final String image_url;
  final String address;
  final String period;
  final String detail_info;

  DiscoverFestival({
    required this.name,
    required this.image_url,
    required this.address,
    required this.period,
    required this.detail_info,
  });

  // JSON으로부터 DiscoverFestival 객체 생성
  factory DiscoverFestival.fromJson(Map<String, dynamic> json) {
    return DiscoverFestival(
      name: json['name'],
      image_url: json['image_url'],
      address: json['address'],
      period: json['period'],
      detail_info: json['detail_info'],
    );
  }
}
