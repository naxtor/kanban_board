import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/presentation/bloc/boards/boards_bloc.dart';
import 'package:kanban_board/presentation/bloc/boards/boards_event.dart';
import 'package:kanban_board/presentation/bloc/boards/boards_state.dart';
import 'package:kanban_board/utils/app_colors.dart';
import 'package:kanban_board/utils/app_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showCreateBoardDialog() {
    showDialog(
      context: context,
      builder: (_) => const CreateBoardDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        elevation: 5,
        onPressed: () => showCreateBoardDialog(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<BoardsBloc, BoardsState>(
        builder: ((context, state) {
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
              children: [
                const Text(
                  "My Boards",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: Builder(
                    builder: (_) {
                      if (state is BoardsHasData) {
                        if (state.boards.isEmpty) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            child: const Text("Create your first board here"),
                          );
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: state.boards.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 16,
                              ),
                              child: InkWell(
                                onTap: () => Navigator.of(context).pushNamed(
                                  "/board_detail",
                                  arguments: e,
                                ),
                                child: Ink(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 16,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        color: Colors.black,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 12,
                                        ),
                                        child: Text(
                                          e.name,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else if (state is BoardsEmpty) {
                        context.read<BoardsBloc>().add(GetBoardsEvent());
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class CreateBoardDialog extends StatefulWidget {
  const CreateBoardDialog({Key? key}) : super(key: key);

  @override
  State<CreateBoardDialog> createState() => _CreateBoardDialogState();
}

class _CreateBoardDialogState extends State<CreateBoardDialog> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Create New Board",
      ),
      content: TextField(
        controller: name,
        decoration: const InputDecoration(
          hintText: "Board name",
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<BoardsBloc>().add(CreateBoardEvent(name.text));
          },
          style: AppStyles.primaryButton,
          child: const Text(
            "Create",
          ),
        ),
      ],
    );
  }
}
