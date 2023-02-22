import 'package:equatable/equatable.dart';
import 'package:kanban_board/domain/entities/board.dart';

abstract class BoardsState extends Equatable {
  @override
  List get props => [];
}

class BoardsEmpty extends BoardsState {}

class BoardsLoading extends BoardsState {}

class BoardsHasData extends BoardsState {
  final List<Board> boards;

  BoardsHasData(this.boards);

  @override
  List get props => [
        boards,
      ];
}
