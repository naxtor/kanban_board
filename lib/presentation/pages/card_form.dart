import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/domain/entities/card.dart';
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_bloc.dart';
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_event.dart';
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_state.dart';
import 'package:kanban_board/utils/app_colors.dart';
import 'package:kanban_board/utils/app_styles.dart';

class CardFormPage extends StatefulWidget {
  const CardFormPage({Key? key}) : super(key: key);

  @override
  State<CardFormPage> createState() => _CardFormPageState();
}

class _CardFormPageState extends State<CardFormPage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  int position = 0;
  late Map<String, dynamic> arguments;
  CardEntity? card;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (arguments["type"] == "EDIT") {
        setState(() {
          card = arguments["card"] as CardEntity;

          title.text = card!.title;
          description.text = card!.description;
          position = card!.position;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var titleStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<BoardDetailBloc, BoardDetailState>(
        builder: (context, state) {
          if (state is BoardDetailHasData) {
            return ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
              children: [
                Text(
                  "Title",
                  style: titleStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                  ),
                  child: TextField(
                    controller: title,
                    decoration: const InputDecoration(
                      hintText: "Your Card Title",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                  ),
                  child: Text(
                    "Description",
                    style: titleStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                  ),
                  child: TextField(
                    controller: description,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      hintText: "Your Card Description",
                    ),
                  ),
                ),
                Builder(
                  builder: (_) {
                    if (arguments["type"] == "EDIT" && card != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 24,
                            ),
                            child: Text(
                              "Description",
                              style: titleStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                            ),
                            child: DropdownButton(
                              isExpanded: true,
                              items: state.lists
                                  .map((e) => DropdownMenuItem<String>(
                                        value: e.id,
                                        child: Text(
                                          e.name,
                                        ),
                                      ))
                                  .toList(),
                              value: card!.listId,
                              onChanged: (value) {
                                setState(() {
                                  card!.listId = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return Container();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                  ),
                  child: ElevatedButton(
                    style: AppStyles.primaryButton,
                    onPressed: () {
                      switch (arguments["type"]) {
                        case "CREATE":
                          context.read<BoardDetailBloc>().add(
                                CreateCardEvent(
                                  title: title.text,
                                  description: description.text,
                                  listId: arguments["listId"]!,
                                  position: int.parse(arguments["position"]!),
                                ),
                              );
                          Future.delayed(const Duration(seconds: 1),
                              () => Navigator.of(context).pop());
                          break;
                        case "EDIT":
                          card!.title = title.text;
                          card!.description = description.text;

                          context
                              .read<BoardDetailBloc>()
                              .add(UpdateCardEvent(card!));

                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          break;
                      }
                    },
                    child: Text(
                      arguments["type"] == "CREATE" ? "Create" : "Save",
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
