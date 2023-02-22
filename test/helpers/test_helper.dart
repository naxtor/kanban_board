import 'package:kanban_board/domain/repositories/board_repository.dart';
import 'package:kanban_board/domain/repositories/card_repository.dart';
import 'package:kanban_board/domain/repositories/list_repository.dart';
import 'package:kanban_board/domain/repositories/profile_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  BoardRepository,
  CardRepository,
  ListRepository,
  ProfileRepository,
])
main() {}
