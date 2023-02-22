import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/firebase_options.dart';
import 'package:kanban_board/injector.dart' as injector;
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_bloc.dart';
import 'package:kanban_board/presentation/bloc/boards/boards_bloc.dart';
import 'package:kanban_board/presentation/bloc/my_cards/my_cards_bloc.dart';
import 'package:kanban_board/presentation/bloc/profile/profile_bloc.dart';
import 'package:kanban_board/presentation/middleware/auth_middleware.dart';
import 'package:kanban_board/presentation/pages/board_detail.dart';
import 'package:kanban_board/presentation/pages/board_form.dart';
import 'package:kanban_board/presentation/pages/card_detail.dart';
import 'package:kanban_board/presentation/pages/card_form.dart';
import 'package:kanban_board/presentation/pages/list_form.dart';
import 'package:kanban_board/presentation/pages/login.dart';
import 'package:kanban_board/presentation/pages/register.dart';
import 'package:kanban_board/presentation/widgets/bottom_navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  injector.setup();

  runApp(const KanbanBoardApp());
}

class KanbanBoardApp extends StatelessWidget {
  const KanbanBoardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector.getIt<BoardsBloc>(),
        ),
        BlocProvider(
          create: (context) => injector.getIt<BoardDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => injector.getIt<MyCardsBloc>(),
        ),
        BlocProvider(
          create: (context) => injector.getIt<ProfileBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/login": (_) => const LoginPage(),
          "/register": (_) => const RegisterPage(),
          "/homepage": (_) => const AuthMiddleware(
                nextPage: BottomNavbar(index: 0),
              ),
          '/board_detail': (context) => const AuthMiddleware(
                nextPage: BoardDetailPage(),
              ),
          '/board_form': (context) => const AuthMiddleware(
                nextPage: BoardFormPage(),
              ),
          '/list_form': (context) => const AuthMiddleware(
                nextPage: ListFormPage(),
              ),
          '/card_form': (context) => const AuthMiddleware(
                nextPage: CardFormPage(),
              ),
          '/card_detail': (context) => const AuthMiddleware(
                nextPage: CardDetailPage(),
              ),
        },
        initialRoute: "/homepage",
      ),
    );
  }
}
