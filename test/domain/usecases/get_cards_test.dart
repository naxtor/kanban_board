import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/domain/entities/card.dart';

import 'package:kanban_board/domain/usecases/get_cards.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockCardRepository repository;
  late GetCards usecase;

  setUp(() {
    repository = MockCardRepository();
    usecase = GetCards(repository);
  });

  final list = [
    CardEntity(
      id: "1",
      title: "Card",
      description: "Task 1 Description",
      listId: "1",
      totalSpent: 0,
      position: 1,
    ),
  ];

  const listId = "1";

  test('Should get list of cards from repository', () async {
    // Arrange
    when(repository.getCards(listId)).thenAnswer((_) async => list);

    // Act
    final result = await usecase.execute(listId);

    // Assert
    expect(result, equals(list));
  });
}
