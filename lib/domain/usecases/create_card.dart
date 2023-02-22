import 'package:kanban_board/domain/entities/card.dart';
import 'package:kanban_board/domain/repositories/card_repository.dart';

class CreateCard {
  CardRepository cardRepository;

  CreateCard(this.cardRepository);

  Future<CardEntity> execute({
    required String title,
    required String description,
    required String listId,
    required int position,
  }) {
    try {
      return cardRepository.createCard(
        title: title,
        description: description,
        listId: listId,
        position: position,
      );
    } catch (e) {
      rethrow;
    }
  }
}
