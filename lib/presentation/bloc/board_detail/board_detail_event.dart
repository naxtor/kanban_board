import 'package:equatable/equatable.dart';
import 'package:kanban_board/domain/entities/board.dart';
import 'package:kanban_board/domain/entities/card.dart';

abstract class BoardDetailEvent extends Equatable {
  @override
  List get props => [];
}

class GetBoardDetailEvent extends BoardDetailEvent {
  final Board board;

  GetBoardDetailEvent(this.board);

  @override
  List get props => [
        board,
      ];
}

class ClearBoardDetail extends BoardDetailEvent {}

class CreateListEvent extends BoardDetailEvent {
  final String name;
  final String boardId;
  final int position;

  CreateListEvent(
      {required this.name, required this.boardId, required this.position});

  @override
  List get props => [
        name,
        boardId,
        position,
      ];
}

class CreateCardEvent extends BoardDetailEvent {
  final String title;
  final String description;
  final String listId;
  final int position;

  CreateCardEvent({
    required this.title,
    required this.description,
    required this.listId,
    required this.position,
  });

  @override
  List get props => [
        title,
        description,
        listId,
        position,
      ];
}

class StartTrackingEvent extends BoardDetailEvent {
  final String cardId;
  final String startAt;

  StartTrackingEvent(
    this.cardId, {
    required this.startAt,
  });

  @override
  List get props => [
        cardId,
        startAt,
      ];
}

class StopTrackingEvent extends BoardDetailEvent {
  final String cardId;
  final String endAt;
  final int totalSpent;

  StopTrackingEvent(
    this.cardId, {
    required this.endAt,
    required this.totalSpent,
  });

  @override
  List get props => [
        cardId,
        endAt,
      ];
}

class MarkAsDoneEvent extends BoardDetailEvent {
  final String cardId;
  final String finishedAt;

  MarkAsDoneEvent(
    this.cardId, {
    required this.finishedAt,
  });

  @override
  List get props => [
        cardId,
        finishedAt,
      ];
}

class UpdateCardEvent extends BoardDetailEvent {
  final CardEntity card;

  UpdateCardEvent(this.card);

  @override
  List get props => [
        card,
      ];
}
