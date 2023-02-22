import 'package:equatable/equatable.dart';

abstract class MyCardsEvent extends Equatable {
  @override
  List get props => [];
}

class GetMyCardsEvent extends MyCardsEvent {}

class ClearMyCardsEvent extends MyCardsEvent {}
