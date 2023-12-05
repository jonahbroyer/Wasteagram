class FoodWastePost {
  final String id;
  final DateTime date;
  final String photoURL;
  final int quantity;
  final double latitude;
  final double longitude;

  FoodWastePost(
      {required this.id,
      required this.date,
      required this.photoURL,
      required this.quantity,
      required this.latitude,
      required this.longitude});

  factory FoodWastePost.fromMap(Map<String, dynamic> map) {
    return FoodWastePost(
        id: map['id'],
        date: DateTime.parse(map['date']),
        photoURL: map['photoURL'],
        quantity: int.parse(map['quantity']),
        latitude: double.parse(map['latitude']),
        longitude: double.parse(map['longitude']));
  }
}
