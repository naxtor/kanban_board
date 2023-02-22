class ListEntity {
  ListEntity({
    required this.id,
    required this.name,
    required this.boardId,
    required this.position,
  });

  String id;
  String name;
  String boardId;
  int position;

  Map<String, dynamic> toJson() => {
        "name": name,
        "board_id": boardId,
        "position": position,
      };
}
