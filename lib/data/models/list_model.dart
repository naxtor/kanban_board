import 'package:kanban_board/domain/entities/list.dart';

class ListModel {
  ListModel({
    required this.name,
    required this.boardId,
    required this.position,
  });

  String name;
  String boardId;
  int position;

  factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        name: json["name"],
        boardId: json["board_id"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "board_id": boardId,
        "position": position,
      };

  ListEntity toEntity(String id) => ListEntity(
        id: id,
        name: name,
        boardId: boardId,
        position: position,
      );
}
