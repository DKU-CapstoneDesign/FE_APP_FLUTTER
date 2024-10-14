class DiscoverAdvertisement {
  final String name;
  final String image_url;
  final String price;


  DiscoverAdvertisement({
    required this.name,
    required this.image_url,
    required this.price
  });

  // JSON으로부터 DiscoverAdvertisement 객체 생성
  factory DiscoverAdvertisement.fromJson(Map<String, dynamic> json) {
    return DiscoverAdvertisement(
      name: json['name'],
      image_url: json['image_url'],
      price: json['price'],
    );
  }
}
