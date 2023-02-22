import 'package:equatable/equatable.dart';
import 'package:kanban_board/domain/entities/card.dart';

abstract class MyCardsState extends Equatable {
  @override
  List get props => [];
}

class MyCardsEmpty extends MyCardsState {}

class MyCardsLoading extends MyCardsState {}

class MyCardsHasData extends MyCardsState {
  final List<CardEntity> cards;

  MyCardsHasData(this.cards);

  @override
  List get props => [
        cards,
      ];
}
