class Campaign {
  final String id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  // Add other fields as needed

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }
} 