class CardEntity {
  CardEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.listId,
    this.startAt,
    this.endAt,
    this.finishedAt,
    required this.totalSpent,
    required this.position,
  });

  String id;
  String title;
  String description;
  String listId;
  DateTime? startAt;
  DateTime? endAt;
  DateTime? finishedAt;
  int totalSpent;
  int position;

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "list_id": listId,
        "total_spent": totalSpent,
        "position": position,
      };
}
