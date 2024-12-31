class Campaign {
  final String id;
  final String title;
  final String description;
  final String organizer;
  final double goalAmount;
  final double currentAmount;
  final DateTime createdAt;
  final String imageUrl;
  final double latitude;
  final double longitude;

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.organizer,
    required this.goalAmount,
    required this.currentAmount,
    required this.createdAt,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      organizer: json['organizer'],
      goalAmount: json['goalAmount'].toDouble(),
      currentAmount: json['currentAmount'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      imageUrl: json['imageUrl'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),

    );
  }
} 