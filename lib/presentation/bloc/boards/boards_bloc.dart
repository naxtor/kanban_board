import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/domain/usecases/create_board.dart';
import 'package:kanban_board/domain/usecases/get_boards.dart';
import 'package:kanban_board/presentation/bloc/boards/boards_event.dart';
import 'package:kanban_board/presentation/bloc/boards/boards_state.dart';

class BoardsBloc extends Bloc<BoardsEvent, BoardsState> {
  GetBoards getBoards;
  CreateBoard createBoard;

  BoardsBloc({
    required this.getBoards,
    required this.createBoard,
  }) : super(BoardsEmpty()) {
    on<GetBoardsEvent>((event, emit) async {
      emit(BoardsLoading());

      final boards = await getBoards.execute();

      emit(BoardsHasData(boards));
    });
    on<CreateBoardEvent>((event, emit) async {
      if (state is BoardsHasData) {
        final currentState = state as BoardsHasData;

        final board = await createBoard.execute(event.name);

        final boards = List.of(currentState.boards);
        boards.add(board);

        emit(BoardsHasData(boards));
      }
    });
    on<ClearBoardEvent>((event, emit) => emit(BoardsEmpty()));
  }
}
