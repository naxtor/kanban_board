import 'package:kanban_board/domain/entities/board.dart';
import 'package:kanban_board/domain/repositories/board_repository.dart';

class CreateBoard {
  BoardRepository boardRepository;

  CreateBoard(this.boardRepository);

  Future<Board> execute(String name) {
    try {
      return boardRepository.createBoard(name);
    } catch (e) {
      rethrow;
    }
  }
}
