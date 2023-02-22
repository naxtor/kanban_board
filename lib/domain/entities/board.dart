class Board {
  Board({
    required this.id,
    required this.name,
    required this.userId,
  });

  String id;
  String name;
  String userId;

  Map<String, dynamic> toJson() => {
        "name": name,
        "user_id": userId,
      };
}
