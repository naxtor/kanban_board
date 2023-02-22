import 'package:kanban_board/domain/entities/card.dart';
import 'package:kanban_board/domain/repositories/card_repository.dart';

class GetCards {
  CardRepository cardRepository;

  GetCards(this.cardRepository);

  Future<List<CardEntity>> execute(String listId) {
    try {
      return cardRepository.getCards(listId);
    } catch (e) {
      rethrow;
    }
  }
}
