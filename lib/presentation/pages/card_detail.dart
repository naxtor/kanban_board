import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/domain/entities/card.dart';
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_bloc.dart';
import 'package:kanban_board/presentation/bloc/board_detail/board_detail_event.dart';
import 'package:kanban_board/utils/app_colors.dart';
import 'package:kanban_board/utils/app_styles.dart';
import 'package:kanban_board/utils/time_converter.dart';

class CardDetailPage extends StatefulWidget {
  const CardDetailPage({Key? key}) : super(key: key);

  @override
  State<CardDetailPage> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends State<CardDetailPage> {
  late CardEntity card;

  @override
  Widget build(BuildContext context) {
    card = ModalRoute.of(context)!.settings.arguments as CardEntity;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: const Text(
          "Detail",
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),
        children: [
          Text(
            card.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
            ),
            child: Text(
              card.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
            ),
            child: Text(
              "Position : ${card.position}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
            ),
            child: Text(
              "Time spent : ${TimeConverter.intToTime(card.totalSpent)}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
            ),
            child: ElevatedButton(
              style: AppStyles.primaryButton,
              onPressed: () {
                setState(() {
                  if (card.startAt == null ||
                      (card.startAt != null && card.endAt != null)) {
                    if (card.startAt != null && card.endAt != null) {
                      card.endAt = null;
                    }

                    card.startAt = DateTime.now();

                    context.read<BoardDetailBloc>().add(StartTrackingEvent(
                          card.id,
                          startAt: card.startAt.toString(),
                        ));
                  } else {
                    card.endAt = DateTime.now();

                    final totalSpent =
                        card.endAt!.difference(card.startAt!).inSeconds +
                            card.totalSpent;

                    card.totalSpent = totalSpent;

                    context.read<BoardDetailBloc>().add(StopTrackingEvent(
                          card.id,
                          endAt: card.endAt.toString(),
                          totalSpent: totalSpent,
                        ));
                  }
                });
              },
              child: Text(card.startAt == null ||
                      (card.startAt != null && card.endAt != null)
                  ? "Start Tracking"
                  : "Stop Tracking"),
            ),
          ),
          Builder(builder: (_) {
            if (card.finishedAt != null) {
              return Container();
            }

            return Padding(
              padding: const EdgeInsets.only(
                top: 24,
              ),
              child: ElevatedButton(
                style: AppStyles.primaryButton,
                onPressed: () {
                  setState(() {
                    card.finishedAt = DateTime.now();
                  });

                  context.read<BoardDetailBloc>().add(MarkAsDoneEvent(
                        card.id,
                        finishedAt: card.finishedAt.toString(),
                      ));
                },
                child: const Text("Mark as Done"),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
            ),
            child: TextButton(
              style: AppStyles.secondaryButton,
              onPressed: () => Navigator.of(context).pushNamed(
                "/card_form",
                arguments: {
                  "type": "EDIT",
                  "card": card,
                },
              ),
              child: const Text("Edit"),
            ),
          ),
        ],
      ),
    );
  }
}
