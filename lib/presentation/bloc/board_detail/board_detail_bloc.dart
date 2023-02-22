import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/domain/entities/card.dart';
import 'package:kanban_board/domain/usecases/create_card.dart';
import 'package:kanban_board/domain/usecases/create_list.dart';
import 'package:kanban_board/domain/usecases/get_cards.dart';
import 'package:kanban_board/domain/usecases/get_lists.dart';
import 'package:kanban_board/domain/usecases/mark_as_done.dart';
import 'package:kanban_board/domain/usecases/start_tracking.dart';
import 'package:kanban_board/domain/usecases/stop_tracking.dart';
import 'package:kanban_board/domain/usecases/update_card.dart';
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_event.dart';
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_state.dart';

class BoardDetailBloc extends Bloc<BoardDetailEvent, BoardDetailState> {
  GetLists getLists;
  CreateList createList;
  GetCards getCards;
  CreateCard createCard;
  StartTracking startTracking;
  StopTracking stopTracking;
  MarkAsDone markAsDone;
  UpdateCard updateCard;

  BoardDetailBloc({
    required this.getLists,
    required this.createList,
    required this.getCards,
    required this.createCard,
    required this.startTracking,
    required this.stopTracking,
    required this.markAsDone,
    required this.updateCard,
  }) : super(BoardDetailEmpty()) {
    on<GetBoardDetailEvent>((event, emit) async {
      emit(BoardDetailLoading());

      final lists = await getLists.execute(event.board.id);

      List<CardEntity> cards = [];

      await Future.forEach(lists,
          (element) async => cards += await getCards.execute(element.id));

      emit(BoardDetailHasData(
        board: event.board,
        lists: lists,
        cards: cards,
      ));
    });
    on<ClearBoardDetail>((event, emit) {
      emit(BoardDetailEmpty());
    });
    on<CreateListEvent>((event, emit) async {
      if (state is BoardDetailHasData) {
        final currentState = state as BoardDetailHasData;

        final list = await createList.execute(
          name: event.name,
          boardId: event.boardId,
          position: event.position,
        );

        final lists = List.of(currentState.lists);
        lists.add(list);

        emit(currentState.copyWith(
          lists: lists,
        ));
      }
    });
    on<CreateCardEvent>((event, emit) async {
      if (state is BoardDetailHasData) {
        final currentState = state as BoardDetailHasData;

        final card = await createCard.execute(
          title: event.title,
          description: event.description,
          listId: event.listId,
          position: event.position,
        );

        final cards = List.of(currentState.cards);
        cards.add(card);
        cards.sort(
          (a, b) => a.position.compareTo(b.position),
        );

        emit(currentState.copyWith(
          cards: cards,
        ));
      }
    });
    on<StartTrackingEvent>((event, emit) async {
      if (state is BoardDetailHasData) {
        final currentState = state as BoardDetailHasData;

        final cards = List.of(currentState.cards);
        final cardIndex =
            cards.indexWhere((element) => element.id == event.cardId);
        final card = cards[cardIndex];

        await startTracking.execute(
          event.cardId,
          startAt: event.startAt,
          endAt: card.endAt?.toString(),
        );

        card.startAt = DateTime.parse(event.startAt);
        if (card.endAt != null) {
          card.endAt = null;
        }

        cards[cardIndex] = card;

        emit(currentState.copyWith(
          cards: cards,
        ));
      }
    });
    on<StopTrackingEvent>((event, emit) async {
      if (state is BoardDetailHasData) {
        final currentState = state as BoardDetailHasData;

        final cards = List.of(currentState.cards);
        final cardIndex =
            cards.indexWhere((element) => element.id == event.cardId);
        final card = cards[cardIndex];

        await stopTracking.execute(
          event.cardId,
          endAt: event.endAt,
          totalSpent: event.totalSpent,
        );

        card.endAt = DateTime.parse(event.endAt);
        cards[cardIndex] = card;

        emit(currentState.copyWith(
          cards: cards,
        ));
      }
    });
    on<MarkAsDoneEvent>((event, emit) async {
      if (state is BoardDetailHasData) {
        final currentState = state as BoardDetailHasData;

        await markAsDone.execute(
          event.cardId,
          finishedAt: event.finishedAt,
        );

        final cards = List.of(currentState.cards);
        final cardIndex =
            cards.indexWhere((element) => element.id == event.cardId);
        final card = cards[cardIndex];

        card.finishedAt = DateTime.parse(event.finishedAt);
        cards[cardIndex] = card;

        emit(currentState.copyWith(
          cards: cards,
        ));
      }
    });
    on<UpdateCardEvent>((event, emit) async {
      if (state is BoardDetailHasData) {
        final currentState = state as BoardDetailHasData;

        final cards = List.of(currentState.cards);
        final cardIndex =
            cards.indexWhere((element) => element.id == event.card.id);

        emit(BoardDetailLoading());

        await updateCard.execute(card: event.card);

        cards[cardIndex] = event.card;

        emit(currentState.copyWith(
          cards: cards,
        ));
      }
    });
  }
}
