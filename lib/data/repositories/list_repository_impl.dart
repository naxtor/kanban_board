import 'package:kanban_board/data/datasources/firestore_service.dart';
import 'package:kanban_board/domain/entities/list.dart';
import 'package:kanban_board/domain/repositories/list_repository.dart';

class ListRepositoryImplement extends ListRepository {
  FireStoreService fireStoreService;

  ListRepositoryImplement(this.fireStoreService);

  @override
  Future<List<ListEntity>> getLists(String boardId) async {
    final result = await fireStoreService.getLists(boardId);

    return result.map((e) => e.data().toEntity(e.id)).toList()
      ..sort(
        (a, b) => a.position.compareTo(b.position),
      );
  }

  @override
  Future<ListEntity> createList({
    required String name,
    required String boardId,
    required int position,
  }) async {
    final result = await fireStoreService.createList(
      name: name,
      boardId: boardId,
      position: position,
    );

    return result.data()!.toEntity(result.id);
  }
}
