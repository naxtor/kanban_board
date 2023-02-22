import 'package:kanban_board/domain/repositories/card_repository.dart';

class StartTracking {
  CardRepository cardRepository;

  StartTracking(this.cardRepository);

  Future<void> execute(
    String cardId, {
    required String startAt,
    String? endAt,
  }) {
    try {
      return cardRepository.startTracking(
        cardId,
        startAt: startAt,
        endAt: endAt,
      );
    } catch (e) {
      rethrow;
    }
  }
}
