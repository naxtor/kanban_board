import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kanban_board/data/datasources/auth_service.dart';
import 'package:kanban_board/data/models/board_model.dart';
import 'package:kanban_board/data/models/card_model.dart';
import 'package:kanban_board/data/models/list_model.dart';

abstract class FireStoreService {
  CollectionReference<BoardModel> get boardsRef;
  Future<List<QueryDocumentSnapshot<BoardModel>>> getBoards();
  Future<DocumentSnapshot<BoardModel>> createBoard(String name);

  CollectionReference<ListModel> get listsRef;
  Future<List<QueryDocumentSnapshot<ListModel>>> getLists(String boardId);
  Future<DocumentSnapshot<ListModel>> createList({
    required String name,
    required String boardId,
    required int position,
  });

  CollectionReference<CardModel> get cardsRef;
  Future<List<QueryDocumentSnapshot<CardModel>>> getCards(String listId);
  Future<DocumentSnapshot<CardModel>> createCard({
    required String title,
    required String description,
    required String listId,
    required int position,
  });
  Future<void> startTracking(
    String cardId, {
    required String startAt,
    String? endAt,
  });
  Future<void> stopTracking(
    String cardId, {
    required String endAt,
    required int totalSpent,
  });
  Future<void> markAsDone(
    String cardId, {
    required String finishedAt,
  });
  Future<void> updateCard(
    String cardId, {
    required CardModel cardModel,
  });
}

class FireStoreServiceImplement extends FireStoreService {
  final AuthService authService;

  FireStoreServiceImplement(this.authService);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  CollectionReference<BoardModel> get boardsRef {
    return firestore.collection("/boards").withConverter<BoardModel>(
          fromFirestore: ((snapshot, options) =>
              BoardModel.fromJson(snapshot.data()!)),
          toFirestore: ((value, options) => value.toJson()),
        );
  }

  @override
  Future<List<QueryDocumentSnapshot<BoardModel>>> getBoards() async {
    final boards = await boardsRef
        .where(
          "user_id",
          isEqualTo: authService.userDetail.uid,
        )
        .get()
        .then((value) => value.docs);

    return boards;
  }

  @override
  Future<DocumentSnapshot<BoardModel>> createBoard(String name) async {
    final board = await boardsRef
        .add(BoardModel(
          name: name,
          userId: authService.userDetail.uid,
        ))
        .then((value) => value.get());

    return board;
  }

  @override
  CollectionReference<ListModel> get listsRef {
    return firestore.collection("/lists").withConverter<ListModel>(
          fromFirestore: ((snapshot, options) =>
              ListModel.fromJson(snapshot.data()!)),
          toFirestore: ((value, options) => value.toJson()),
        );
  }

  @override
  Future<List<QueryDocumentSnapshot<ListModel>>> getLists(
      String boardId) async {
    final lists = await listsRef
        .where(
          "board_id",
          isEqualTo: boardId,
        )
        .get()
        .then((value) => value.docs);

    return lists;
  }

  @override
  Future<DocumentSnapshot<ListModel>> createList({
    required String name,
    required String boardId,
    required int position,
  }) async {
    final list = await listsRef
        .add(ListModel(
          name: name,
          boardId: boardId,
          position: position,
        ))
        .then((value) => value.get());

    return list;
  }

  @override
  CollectionReference<CardModel> get cardsRef {
    return firestore.collection("/cards").withConverter<CardModel>(
          fromFirestore: ((snapshot, options) =>
              CardModel.fromJson(snapshot.data()!)),
          toFirestore: ((value, options) => value.toJson()),
        );
  }

  @override
  Future<List<QueryDocumentSnapshot<CardModel>>> getCards(String listId) async {
    final cards = await cardsRef
        .where(
          "list_id",
          isEqualTo: listId,
        )
        .get()
        .then((value) => value.docs);

    return cards;
  }

  @override
  Future<DocumentSnapshot<CardModel>> createCard({
    required String title,
    required String description,
    required String listId,
    required int position,
  }) async {
    final card = await cardsRef
        .add(CardModel(
          title: title,
          description: description,
          listId: listId,
          position: position,
          totalSpent: 0,
        ))
        .then((value) => value.get());

    return card;
  }

  @override
  Future<void> startTracking(
    String cardId, {
    required String startAt,
    String? endAt,
  }) async {
    Map<Object, Object> payload = {
      "start_at": startAt,
    };

    if (endAt != null) {
      payload.addAll({
        "endAt": FieldValue.delete(),
      });
    }

    await cardsRef.doc(cardId).update(payload);
  }

  @override
  Future<void> stopTracking(String cardId,
      {required String endAt, required int totalSpent}) async {
    await cardsRef.doc(cardId).update({
      "end_at": endAt,
      "total_spent": totalSpent,
    });
  }

  @override
  Future<void> markAsDone(
    String cardId, {
    required String finishedAt,
  }) async {
    await cardsRef.doc(cardId).update({
      "finished_at": finishedAt,
    });
  }

  @override
  Future<void> updateCard(
    String cardId, {
    required CardModel cardModel,
  }) async {
    await cardsRef.doc(cardId).update(cardModel.toJson());
  }
}
