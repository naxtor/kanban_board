import 'package:kanban_board/data/datasources/firestore_service.dart';
import 'package:kanban_board/domain/entities/board.dart';
import 'package:kanban_board/domain/repositories/board_repository.dart';

class BoardRepositoryImplement extends BoardRepository {
  FireStoreService fireStoreService;

  BoardRepositoryImplement(this.fireStoreService);

  @override
  Future<List<Board>> getBoards() async {
    final result = await fireStoreService.getBoards();

    return result.map((e) => e.data().toEntity(e.id)).toList()
      ..sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
  }

  @override
  Future<Board> createBoard(String name) async {
    final result = await fireStoreService.createBoard(name);

    return result.data()!.toEntity(result.id);
  }
}
