import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/presentation/bloc/boards/boards_bloc.dart';
import 'package:kanban_board/presentation/bloc/boards/boards_event.dart';
import 'package:kanban_board/presentation/bloc/my_cards/my_cards_bloc.dart';
import 'package:kanban_board/presentation/bloc/my_cards/my_cards_event.dart';
import 'package:kanban_board/presentation/bloc/profile/profile_bloc.dart';
import 'package:kanban_board/presentation/bloc/profile/profile_event.dart';
import 'package:kanban_board/presentation/bloc/profile/profile_state.dart';
import 'package:kanban_board/utils/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileHasData) {
            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 40,
                ),
                children: [
                  const Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 40,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.primary,
                          ),
                          child: Center(
                            child: Text(
                              state.user.email!.toUpperCase().substring(0, 1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 14,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  state.user.email!,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 12,
                                    bottom: 12,
                                  ),
                                  child: Text(
                                    "Member since: ${state.user.metadata.creationTime}",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Menu",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                    ),
                    child: InkWell(
                      onTap: () {
                        context.read<ProfileBloc>().add(LogoutEvent(context));
                        context.read<BoardsBloc>().add(ClearBoardEvent());
                        context.read<MyCardsBloc>().add(ClearMyCardsEvent());
                      },
                      child: Ink(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        child: Row(children: const [
                          Icon(
                            Icons.logout,
                            size: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 12,
                            ),
                            child: Text("Logout"),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
