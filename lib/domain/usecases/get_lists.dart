import 'package:kanban_board/domain/entities/list.dart';
import 'package:kanban_board/domain/repositories/list_repository.dart';

class GetLists {
  ListRepository listRepository;

  GetLists(this.listRepository);

  Future<List<ListEntity>> execute(String boardId) {
    try {
      return listRepository.getLists(boardId);
    } catch (e) {
      rethrow;
    }
  }
}
