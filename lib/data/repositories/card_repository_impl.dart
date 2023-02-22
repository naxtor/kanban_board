import 'package:kanban_board/data/datasources/firestore_service.dart';
import 'package:kanban_board/data/models/card_model.dart';
import 'package:kanban_board/domain/entities/card.dart';
import 'package:kanban_board/domain/repositories/card_repository.dart';

class CardRepositoryImplement extends CardRepository {
  FireStoreService fireStoreService;

  CardRepositoryImplement(this.fireStoreService);

  @override
  Future<List<CardEntity>> getCards(String listId) async {
    final result = await fireStoreService.getCards(listId);

    return result.map((e) => e.data().toEntity(e.id)).toList()
      ..sort(
        (a, b) => a.position.compareTo(b.position),
      );
  }

  @override
  Future<CardEntity> createCard({
    required String title,
    required String description,
    required String listId,
    required int position,
  }) async {
    final result = await fireStoreService.createCard(
      title: title,
      description: description,
      listId: listId,
      position: position,
    );

    return result.data()!.toEntity(result.id);
  }

  @override
  Future<void> startTracking(String cardId,
      {required String startAt, String? endAt}) async {
    await fireStoreService.startTracking(
      cardId,
      startAt: startAt,
      endAt: endAt,
    );
  }

  @override
  Future<void> stopTracking(
    String cardId, {
    required String endAt,
    required int totalSpent,
  }) async {
    await fireStoreService.stopTracking(
      cardId,
      endAt: endAt,
      totalSpent: totalSpent,
    );
  }

  @override
  Future<void> markAsDone(
    String cardId, {
    required String finishedAt,
  }) async {
    await fireStoreService.markAsDone(
      cardId,
      finishedAt: finishedAt,
    );
  }

  @override
  Future<void> updateCard({
    required CardEntity card,
  }) async {
    await fireStoreService.updateCard(
      card.id,
      cardModel: CardModel.fromJson(card.toJson()),
    );
  }
}
