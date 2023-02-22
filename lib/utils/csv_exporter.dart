import 'dart:io';

import 'package:csv/csv.dart';
import 'package:kanban_board/domain/entities/card.dart';
import 'package:kanban_board/domain/entities/list.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CSVExporter {
  static Future<String> export({
    required String boardName,
    required List<ListEntity> lists,
    required List<CardEntity> cards,
  }) async {
    String path = "";

    if (await Permission.storage.request().isGranted) {
      // Mapping the list first
      Map<String, String> listNames = {};

      await Future.forEach(lists, (e) => listNames.addAll({e.id: e.name}));

      List<List<dynamic>> rows = [];

      List row = [];
      row.add("No");
      row.add("Title");
      row.add("Description");
      row.add("List");

      rows.add(row);

      int no = 1;

      await Future.forEach(cards, (e) {
        row = [];

        row.add(no);
        row.add(e.title);
        row.add(e.description);
        row.add(listNames[e.listId]);

        rows.add(row);
      });

      String csv = const ListToCsvConverter().convert(rows);

      final dir = await getExternalStorageDirectory();
      path = "${dir!.path}/$boardName.csv";

      File file = File(path);

      await file.writeAsString(csv);
    }

    return path;
  }
}
