import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/domain/entities/list.dart';
import 'package:kanban_board/domain/usecases/create_list.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockListRepository repository;
  late CreateList usecase;

  setUp(() {
    repository = MockListRepository();
    usecase = CreateList(repository);
  });

  final testListDetail = ListEntity(
    id: "1",
    name: "TODO",
    boardId: "1",
    position: 1,
  );

  const name = "TODO";
  const boardId = "1";
  const position = 1;

  test('Should get created list detail from repository', () async {
    // Arrange
    when(repository.createList(
      name: name,
      boardId: boardId,
      position: position,
    )).thenAnswer((_) async => testListDetail);

    // Act
    final result = await usecase.execute(
      name: name,
      boardId: boardId,
      position: position,
    );

    // Assert
    expect(result, equals(testListDetail));
  });
}
