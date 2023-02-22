import 'package:kanban_board/domain/entities/card.dart';
import 'package:kanban_board/domain/repositories/card_repository.dart';

class UpdateCard {
  CardRepository cardRepository;

  UpdateCard(this.cardRepository);

  Future<void> execute({
    required CardEntity card,
  }) {
    try {
      return cardRepository.updateCard(
        card: card,
      );
    } catch (e) {
      rethrow;
    }
  }
}
