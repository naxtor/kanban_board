import 'package:kanban_board/domain/entities/board.dart';
import 'package:kanban_board/domain/repositories/board_repository.dart';

class GetBoards {
  BoardRepository boardRepository;

  GetBoards(this.boardRepository);

  Future<List<Board>> execute() {
    try {
      return boardRepository.getBoards();
    } catch (e) {
      rethrow;
    }
  }
}
