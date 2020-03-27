import 'dart:convert';

import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:vocabular/app/models/box.dart';
import 'package:vocabular/app/models/vocab.dart';
import 'package:vocabular/app/repositories/file_services.dart';
import 'package:vocabular/app/repositories/vocab_repository.dart';

part 'export_controller.g.dart';

class ExportController = _ExportControllerBase with _$ExportController;

abstract class _ExportControllerBase with Store {
  VocabRepository repo;
  FileServices fileServices;

  _ExportControllerBase(this.repo, this.fileServices);

  Box box;

  @observable
  bool isLoading = true;

  @observable
  List<Vocab> vocabs = [];

  @observable
  ObservableSet<Vocab> selected;

  @observable
  bool justExportVocabs = false;

  @observable
  bool includeCompartments = true;

  @action
  void select(Vocab v) {
    if (selected.contains(v))
      selected.remove(v);
    else
      selected.add(v);
  }

  Future loadVocabs(Box b) async {
    isLoading = true;

    box = b;
    if (box != null && box.vocabIds != null && box.vocabIds.isNotEmpty) {
      vocabs = await repo.getVocabs(box.vocabIds, box.lang);

      // if empty ones exist delete
      vocabs = vocabs?.where((v) => v.id != null)?.toList() ?? [];
      selected = ObservableSet.of(vocabs);
    } else {
      selected = ObservableSet.of([]);
    }
    isLoading = false;
  }

  Future<bool> export() async {
    final res = <String, dynamic>{
      'vocabs': selected.map((v) => v.toMap()).toList()
    };

    if (!justExportVocabs) {
      var mybox = box;

      if (includeCompartments) {
        // only keep the compartments with the selected ids
        mybox = box.copyWith(
          compartments: box.compartments
              .map(
                (c) => c
                    .where((v) => selected.any((vocab) => vocab.id == v.id))
                    .toList(),
              )
              .toList(),
        );
      }

      final boxMap = mybox.toMap();

      boxMap.remove('latest');
      boxMap.remove('id');
      boxMap.remove('vocabIds');

      if (!includeCompartments) {
        boxMap.remove('compartments');
      }

      res['box'] = boxMap;
    }

    try {
      final path = await fileServices.saveFile(
        box.title + '.vocab',
        json.encode(res),
      );
      print(path);
      return path != null ? true : null;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
