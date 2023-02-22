import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/domain/entities/list.dart';
import 'package:kanban_board/domain/usecases/get_lists.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockListRepository repository;
  late GetLists usecase;

  setUp(() {
    repository = MockListRepository();
    usecase = GetLists(repository);
  });

  final list = [
    ListEntity(
      id: "1",
      name: "TODO",
      boardId: "1",
      position: 1,
    ),
  ];

  const boardId = "1";

  test('Should get list of lists from repository', () async {
    // Arrange
    when(repository.getLists(boardId)).thenAnswer((_) async => list);

    // Act
    final result = await usecase.execute(boardId);

    // Assert
    expect(result, equals(list));
  });
}
