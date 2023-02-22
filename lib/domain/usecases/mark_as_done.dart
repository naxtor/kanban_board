import 'package:kanban_board/domain/repositories/card_repository.dart';

class MarkAsDone {
  CardRepository cardRepository;

  MarkAsDone(this.cardRepository);

  Future<void> execute(
    String cardId, {
    required String finishedAt,
  }) {
    try {
      return cardRepository.markAsDone(
        cardId,
        finishedAt: finishedAt,
      );
    } catch (e) {
      rethrow;
    }
  }
}
