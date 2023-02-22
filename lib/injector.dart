import 'package:get_it/get_it.dart';
import 'package:kanban_board/data/datasources/auth_service.dart';
import 'package:kanban_board/data/datasources/firestore_service.dart';
import 'package:kanban_board/data/repositories/board_repository_impl.dart';
import 'package:kanban_board/data/repositories/card_repository_impl.dart';
import 'package:kanban_board/data/repositories/list_repository_impl.dart';
import 'package:kanban_board/data/repositories/profile_repository_imp.dart';
import 'package:kanban_board/domain/repositories/board_repository.dart';
import 'package:kanban_board/domain/repositories/card_repository.dart';
import 'package:kanban_board/domain/repositories/list_repository.dart';
import 'package:kanban_board/domain/repositories/profile_repository.dart';
import 'package:kanban_board/domain/usecases/create_board.dart';
import 'package:kanban_board/domain/usecases/create_card.dart';
import 'package:kanban_board/domain/usecases/create_list.dart';
import 'package:kanban_board/domain/usecases/get_boards.dart';
import 'package:kanban_board/domain/usecases/get_cards.dart';
import 'package:kanban_board/domain/usecases/get_lists.dart';
import 'package:kanban_board/domain/usecases/get_user_detail.dart';
import 'package:kanban_board/domain/usecases/logout.dart';
import 'package:kanban_board/domain/usecases/mark_as_done.dart';
import 'package:kanban_board/domain/usecases/start_tracking.dart';
import 'package:kanban_board/domain/usecases/stop_tracking.dart';
import 'package:kanban_board/domain/usecases/update_card.dart';
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_bloc.dart';
import 'package:kanban_board/presentation/bloc/boards/boards_bloc.dart';
import 'package:kanban_board/presentation/bloc/my_cards/my_cards_bloc.dart';
import 'package:kanban_board/presentation/bloc/profile/profile_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  // register data sources
  getIt.registerLazySingleton<AuthService>(() => AuthServiceImplement());
  getIt.registerLazySingleton<FireStoreService>(
      () => FireStoreServiceImplement(getIt()));

  // Register repositories
  getIt.registerLazySingleton<BoardRepository>(
      () => BoardRepositoryImplement(getIt()));
  getIt.registerLazySingleton<ListRepository>(
      () => ListRepositoryImplement(getIt()));
  getIt.registerLazySingleton<CardRepository>(
      () => CardRepositoryImplement(getIt()));
  getIt.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImplement(getIt()));

  // Register use cases
  getIt.registerLazySingleton(() => GetBoards(getIt()));
  getIt.registerLazySingleton(() => CreateBoard(getIt()));
  getIt.registerLazySingleton(() => GetLists(getIt()));
  getIt.registerLazySingleton(() => CreateList(getIt()));
  getIt.registerLazySingleton(() => GetCards(getIt()));
  getIt.registerLazySingleton(() => CreateCard(getIt()));
  getIt.registerLazySingleton(() => StartTracking(getIt()));
  getIt.registerLazySingleton(() => StopTracking(getIt()));
  getIt.registerLazySingleton(() => MarkAsDone(getIt()));
  getIt.registerLazySingleton(() => UpdateCard(getIt()));
  getIt.registerLazySingleton(() => GetUserDetail(getIt()));
  getIt.registerLazySingleton(() => Logout(getIt()));

  // Register blocs
  getIt.registerLazySingleton(() => BoardsBloc(
        getBoards: getIt(),
        createBoard: getIt(),
      ));
  getIt.registerLazySingleton(() => BoardDetailBloc(
        getLists: getIt(),
        createList: getIt(),
        getCards: getIt(),
        createCard: getIt(),
        markAsDone: getIt(),
        startTracking: getIt(),
        stopTracking: getIt(),
        updateCard: getIt(),
      ));
  getIt.registerLazySingleton(() => MyCardsBloc(
        getBoards: getIt(),
        getLists: getIt(),
        getCards: getIt(),
      ));
  getIt.registerLazySingleton(() => ProfileBloc(
        getUserDetail: getIt(),
        logout: getIt(),
      ));
}
