import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/presentation/bloc/boards/boards_bloc.dart';
import 'package:kanban_board/presentation/bloc/boards/boards_event.dart';
import 'package:kanban_board/presentation/bloc/my_cards/my_cards_bloc.dart';
import 'package:kanban_board/presentation/bloc/my_cards/my_cards_event.dart';
import 'package:kanban_board/presentation/pages/homepage.dart';
import 'package:kanban_board/presentation/pages/my_cards.dart';
import 'package:kanban_board/presentation/pages/profile.dart';

class BottomNavbar extends StatefulWidget {
  final int index;

  const BottomNavbar({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int pageIndex = 0;
  List<Widget> menus = [
    const HomePage(),
    const MyCardsPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();

    setState(() {
      pageIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          switch (value) {
            case 0:
              context.read<BoardsBloc>().add(ClearBoardEvent());
              break;
            case 1:
              context.read<MyCardsBloc>().add(ClearMyCardsEvent());
              break;
          }

          setState(() {
            pageIndex = value;
          });
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
            ),
            label: "My Cards",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
            ),
            label: "Profile",
          ),
        ],
      ),
      body: menus[pageIndex],
    );
  }
}
