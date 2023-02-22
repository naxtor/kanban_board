import 'package:kanban_board/domain/entities/list.dart';
import 'package:kanban_board/domain/repositories/list_repository.dart';

class CreateList {
  ListRepository listRepository;

  CreateList(this.listRepository);

  Future<ListEntity> execute({
    required String name,
    required String boardId,
    required int position,
  }) {
    try {
      return listRepository.createList(
        name: name,
        boardId: boardId,
        position: position,
      );
    } catch (e) {
      rethrow;
    }
  }
}
