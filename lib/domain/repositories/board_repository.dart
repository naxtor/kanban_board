import 'package:kanban_board/domain/entities/board.dart';

abstract class BoardRepository {
  Future<List<Board>> getBoards();
  Future<Board> createBoard(String name);
}
