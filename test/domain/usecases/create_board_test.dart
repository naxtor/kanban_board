import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/domain/entities/board.dart';
import 'package:kanban_board/domain/usecases/create_board.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockBoardRepository repository;
  late CreateBoard usecase;

  setUp(() {
    repository = MockBoardRepository();
    usecase = CreateBoard(repository);
  });

  final testBoardDetail = Board(
    id: "1",
    name: "Board 1",
    userId: "1",
  );

  const boardName = "Board 1";

  test('Should get created board detail from repository', () async {
    // Arrange
    when(repository.createBoard(boardName))
        .thenAnswer((_) async => testBoardDetail);

    // Act
    final result = await usecase.execute(boardName);

    // Assert
    expect(result, equals(testBoardDetail));
  });
}
