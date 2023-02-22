import 'package:kanban_board/domain/entities/list.dart';

abstract class ListRepository {
  Future<List<ListEntity>> getLists(String boardId);
  Future<ListEntity> createList({
    required String name,
    required String boardId,
    required int position,
  });
}
