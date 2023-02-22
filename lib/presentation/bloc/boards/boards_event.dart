import 'package:equatable/equatable.dart';

abstract class BoardsEvent extends Equatable {
  @override
  List get props => [];
}

class GetBoardsEvent extends BoardsEvent {}

class CreateBoardEvent extends BoardsEvent {
  final String name;

  CreateBoardEvent(this.name);

  @override
  List get props => [
        name,
      ];
}

class ClearBoardEvent extends BoardsEvent {}
