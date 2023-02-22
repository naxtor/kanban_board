import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/domain/entities/card.dart';
import 'package:kanban_board/domain/entities/list.dart';
import 'package:kanban_board/domain/usecases/get_boards.dart';
import 'package:kanban_board/domain/usecases/get_cards.dart';
import 'package:kanban_board/domain/usecases/get_lists.dart';
import 'package:kanban_board/presentation/bloc/my_cards/my_cards_event.dart';
import 'package:kanban_board/presentation/bloc/my_cards/my_cards_state.dart';

class MyCardsBloc extends Bloc<MyCardsEvent, MyCardsState> {
  GetBoards getBoards;
  GetLists getLists;
  GetCards getCards;

  MyCardsBloc({
    required this.getBoards,
    required this.getLists,
    required this.getCards,
  }) : super(MyCardsEmpty()) {
    on<GetMyCardsEvent>((event, emit) async {
      emit(MyCardsLoading());

      final boards = await getBoards.execute();

      final List<ListEntity> lists = [];

      await Future.forEach(boards,
          (element) async => lists.addAll(await getLists.execute(element.id)));

      final List<CardEntity> cards = [];

      await Future.forEach(lists,
          (element) async => cards.addAll(await getCards.execute(element.id)));

      emit(MyCardsHasData(cards));
    });
    on<ClearMyCardsEvent>((event, emit) => emit(MyCardsEmpty()));
  }
}
