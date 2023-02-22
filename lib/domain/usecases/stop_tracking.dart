import 'package:kanban_board/domain/repositories/card_repository.dart';

class StopTracking {
  CardRepository cardRepository;

  StopTracking(this.cardRepository);

  Future<void> execute(
    String cardId, {
    required String endAt,
    required int totalSpent,
  }) {
    try {
      return cardRepository.stopTracking(
        cardId,
        endAt: endAt,
        totalSpent: totalSpent,
      );
    } catch (e) {
      rethrow;
    }
  }
}
