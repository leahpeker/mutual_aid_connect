class Campaign {
  final String id;
  final String title;
  final String description;
  final String organizer;
  final double goalAmount;
  final double currentAmount;
  final DateTime createdAt;
  final String imageUrl;

  Campaign({
    required this.id,
    required this.title,
    required this.description,
    required this.organizer,
    required this.goalAmount,
    required this.currentAmount,
    required this.createdAt,
    required this.imageUrl,
  });
}
