class Campaign {
  final String id;
  final String title;
  final String description;
  final String creatorId;
  final double targetAmount;
  final double currentAmount;
  final DateTime createdAt;
  final DateTime endsAt;
  final double locationLat;
  final double locationLng;
  final String? imageUrl;

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.creatorId,
    required this.targetAmount,
    required this.currentAmount,
    required this.createdAt,
    required this.endsAt,
    required this.locationLat,
    required this.locationLng,
    this.imageUrl,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      creatorId: json['creator_id'],
      targetAmount: double.parse(json['target_amount']),
      currentAmount: double.parse(json['current_amount']),
      locationLat: json['location_lat'],
      locationLng: json['location_lng'],
      createdAt: DateTime(
        json['created_at'][0],
        json['created_at'][1],
        json['created_at'][2],
        json['created_at'][3],
        json['created_at'][4],
      ),
      endsAt: DateTime(
        json['ends_at'][0],
        json['ends_at'][1],
        json['ends_at'][2],
        json['ends_at'][3],
        json['ends_at'][4],
      ),
      imageUrl: json['image'],
    );
  }
}
