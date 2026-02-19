class RoomModel {
  final String id;
  final String category;
  final String title;
  final String spesification;
  final List<String> roomImg;
  final List<String> facilities;
  final int price;
  final double rating;

  RoomModel({
    required this.id,
    required this.category,
    required this.title,
    required this.spesification,
    required this.roomImg,
    required this.facilities,
    required this.price,
    required this.rating,
  });

  factory RoomModel.fromFireStore(String id, Map<String, dynamic> data) {
    return RoomModel(
      id: id,
      category: data['category'] ?? 'No Category',
      title: data['title'] ?? 'No Title',
      spesification: data['spesification'] ?? 'No spesification',
      roomImg: List<String>.from(data['roomImg'] ?? []),
      facilities: List<String>.from(data['facilities'] ?? []),
      price: (data['price'] as num?)?.toInt() ?? 0,
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
