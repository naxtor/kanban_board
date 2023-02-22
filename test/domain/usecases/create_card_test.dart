import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/domain/entities/card.dart';
import 'package:kanban_board/domain/usecases/create_card.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockCardRepository repository;
  late CreateCard usecase;

  setUp(() {
    repository = MockCardRepository();
    usecase = CreateCard(repository);
  });

  final testCardDetail = CardEntity(
    id: "1",
    title: "Card",
    description: "Task 1 Description",
    listId: "1",
    totalSpent: 0,
    position: 1,
  );

  const title = "Card";
  const description = "Task 1 Description";
  const listId = "1";
  const position = 1;

  test('Should get created card detail from repository', () async {
    // Arrange
    when(repository.createCard(
      title: title,
      description: description,
      listId: listId,
      position: position,
    )).thenAnswer((_) async => testCardDetail);

    // Act
    final result = await usecase.execute(
      title: title,
      description: description,
      listId: listId,
      position: position,
    );

    // Assert
    expect(result, equals(testCardDetail));
  });
}
