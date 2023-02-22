import 'package:kanban_board/domain/entities/card.dart';

class CardModel {
  CardModel({
    required this.title,
    required this.description,
    required this.listId,
    this.startAt,
    this.endAt,
    this.finishedAt,
    required this.totalSpent,
    required this.position,
  });

  String title;
  String description;
  String listId;
  DateTime? startAt;
  DateTime? endAt;
  DateTime? finishedAt;
  int totalSpent;
  int position;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        title: json["title"],
        description: json["description"],
        listId: json["list_id"],
        startAt: DateTime.tryParse(json["start_at"] ?? ""),
        endAt: DateTime.tryParse(json["end_at"] ?? ""),
        finishedAt: DateTime.tryParse(json["finished_at"] ?? ""),
        totalSpent: json["total_spent"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "list_id": listId,
        ...(startAt != null ? {"start_at": startAt.toString()} : {}),
        ...(endAt != null ? {"end_at": endAt.toString()} : {}),
        ...(finishedAt != null ? {"finished_at": finishedAt.toString()} : {}),
        "total_spent": totalSpent,
        "position": position,
      };

  CardEntity toEntity(String id) => CardEntity(
        id: id,
        title: title,
        description: description,
        listId: listId,
        startAt: startAt,
        endAt: endAt,
        finishedAt: finishedAt,
        totalSpent: totalSpent,
        position: position,
      );
}
