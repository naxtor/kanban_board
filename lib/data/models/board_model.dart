import 'package:kanban_board/domain/entities/board.dart';

class BoardModel {
  BoardModel({
    required this.name,
    required this.userId,
  });

  String name;
  String userId;

  factory BoardModel.fromJson(Map<String, dynamic> json) => BoardModel(
        name: json["name"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "user_id": userId,
      };

  Board toEntity(String id) => Board(
        id: id,
        name: name,
        userId: userId,
      );
}
