import 'package:kanban_board/domain/entities/card.dart';

abstract class CardRepository {
  Future<List<CardEntity>> getCards(String listId);
  Future<CardEntity> createCard({
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
  Future<void> updateCard({
    required CardEntity card,
  });
}
