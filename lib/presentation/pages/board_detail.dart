import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/domain/entities/board.dart';
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_bloc.dart';
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_event.dart';
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_state.dart';
import 'package:kanban_board/utils/app_colors.dart';
import 'package:kanban_board/utils/app_styles.dart';
import 'package:kanban_board/utils/csv_exporter.dart';
import 'package:open_file/open_file.dart';

class BoardDetailPage extends StatefulWidget {
  const BoardDetailPage({Key? key}) : super(key: key);

  @override
  State<BoardDetailPage> createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  PageController pageController = PageController(
    viewportFraction: 0.6,
  );
  late BoardDetailHasData boardDetailState;

  void showCreateListDialog(String boardId, int position) {
    showDialog(
      context: context,
      builder: (_) => CreateListDialog(
        boardId: boardId,
        position: position,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final board = ModalRoute.of(context)!.settings.arguments as Board;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          board.name,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
            ),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () async {
                    final path = await CSVExporter.export(
                      boardName: boardDetailState.board.name,
                      lists: boardDetailState.lists,
                      cards: boardDetailState.cards,
                    );

                    if (path.isNotEmpty) {
                      Future.delayed(
                        const Duration(milliseconds: 500),
                        () =>
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(
                            seconds: 5,
                          ),
                          content: Text("Successfuly exported at '$path'"),
                          action: SnackBarAction(
                            label: "Open",
                            onPressed: () => OpenFile.open(path),
                          ),
                        )),
                      );
                    }
                  },
                  child: const Text(
                    "Export",
                  ),
                ),
              ],
              child: const Icon(
                Icons.more_horiz,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<BoardDetailBloc, BoardDetailState>(
        builder: (context, state) {
          if (state is BoardDetailHasData && state.board.id == board.id) {
            return PageView(
              padEnds: false,
              controller: pageController,
              children: List.generate(
                  state.lists.isEmpty ? 1 : state.lists.length + 1, (index) {
                if (state.lists.isEmpty || index == state.lists.length) {
                  boardDetailState = state;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            top: 12,
                            bottom: 20,
                          ),
                          child: InkWell(
                            onTap: () => showCreateListDialog(
                                state.board.id, state.lists.length + 1),
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 16,
                                    offset: const Offset(0, 4),
                                  )
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 12,
                              ),
                              child: const Text(
                                "Add list",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                final list = state.lists[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.only(
                        left: 20,
                        top: 12,
                        bottom: 20,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              right: 8,
                            ),
                            child: Text(
                              list.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: state.cards
                                .where((element) => element.listId == list.id)
                                .map((e) {
                              return InkWell(
                                onTap: () => Navigator.of(context).pushNamed(
                                  "/card_detail",
                                  arguments: e,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.only(
                                    top: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade100,
                                  ),
                                  child: Text(
                                    e.title,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 12,
                            ),
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                "/card_form",
                                arguments: {
                                  "type": "CREATE",
                                  "listId": list.id,
                                  "position": (state.cards
                                              .where((element) =>
                                                  element.listId == list.id)
                                              .length +
                                          1)
                                      .toString(),
                                },
                              ),
                              child: Text(
                                "+ Add card",
                                style: TextStyle(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
            );
          } else if (state is BoardDetailEmpty ||
              (state is BoardDetailHasData && board.id != state.board.id)) {
            context.read<BoardDetailBloc>().add(GetBoardDetailEvent(board));
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class CreateListDialog extends StatefulWidget {
  final String boardId;
  final int position;
  const CreateListDialog({
    Key? key,
    required this.boardId,
    required this.position,
  }) : super(key: key);

  @override
  State<CreateListDialog> createState() => _CreateListDialogState();
}

class _CreateListDialogState extends State<CreateListDialog> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Create New List",
      ),
      content: TextField(
        controller: name,
        decoration: const InputDecoration(
          hintText: "List name",
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<BoardDetailBloc>().add(CreateListEvent(
                  name: name.text,
                  boardId: widget.boardId,
                  position: widget.position,
                ));
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
