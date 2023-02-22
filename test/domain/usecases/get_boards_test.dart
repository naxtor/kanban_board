import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/domain/entities/board.dart';
import 'package:kanban_board/domain/usecases/get_boards.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockBoardRepository repository;
  late GetBoards usecase;

  setUp(() {
    repository = MockBoardRepository();
    usecase = GetBoards(repository);
  });

  final list = [
    Board(
      id: "1",
      name: "Board 1",
      userId: "1",
    ),
  ];

  test('Should get list of boards from repository', () async {
    // Arrange
    when(repository.getBoards()).thenAnswer((_) async => list);

    // Act
    final result = await usecase.execute();

    // Assert
    expect(result, equals(list));
  });
}
