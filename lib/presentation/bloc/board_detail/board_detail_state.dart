import 'package:equatable/equatable.dart';
import 'package:kanban_board/domain/entities/board.dart';
import 'package:kanban_board/domain/entities/card.dart';
import 'package:kanban_board/domain/entities/list.dart';

abstract class BoardDetailState extends Equatable {
  @override
  List get props => [];
}

class BoardDetailEmpty extends BoardDetailState {}

class BoardDetailLoading extends BoardDetailState {}

class BoardDetailHasData extends BoardDetailState {
  final Board board;
  final List<ListEntity> lists;
  final List<CardEntity> cards;

  BoardDetailHasData({
    required this.board,
    required this.lists,
    required this.cards,
  });

  BoardDetailHasData copyWith({
    Board? board,
    List<ListEntity>? lists,
    List<CardEntity>? cards,
  }) =>
      BoardDetailHasData(
        board: board ?? this.board,
        lists: lists ?? this.lists,
        cards: cards ?? this.cards,
      );

  @override
  List get props => [
        board,
        lists,
        cards,
      ];
}
