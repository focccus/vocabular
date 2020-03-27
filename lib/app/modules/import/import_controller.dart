import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:vocabular/app/models/box.dart';
import 'package:vocabular/app/models/vocab.dart';
import 'package:vocabular/app/repositories/box_repository.dart';
import 'package:vocabular/app/repositories/file_services.dart';
import 'package:vocabular/app/repositories/options_repository.dart';
import 'package:vocabular/app/repositories/vocab_repository.dart';

part 'import_controller.g.dart';

class ImportController = _ImportControllerBase with _$ImportController;

abstract class _ImportControllerBase with Store {
  final FileServices fileServices;
  final VocabRepository vocabRepo;
  final BoxRepository boxRepo;

  _ImportControllerBase(
    this.fileServices,
    this.vocabRepo,
    this.boxRepo,
  );

  @observable
  String errorText;

  @observable
  Map<int, Vocab> vocabsMap;

  Box box;

  @computed
  List<Vocab> get vocabs => vocabsMap.values.toList();

  bool hasFormen;

  @observable
  bool isLoaded = false;

  @observable
  bool importBox = true;

  @observable
  String lang;

  List<String> langs;

  @action
  Future importFile() async {
    isLoaded = false;
    hasFormen = null;
    vocabsMap = {};
    errorText = null;

    try {
      final res = await fileServices.selectFile(['vocab']);
      if (res == null) return;
      final map = json.decode(res);

      if (map['vocabs'] == null) throw ('Vocabs are not present');
      if (map['lang'] != null) {
        lang ??= map['lang'];
      }

      for (var vMap in map['vocabs']) {
        final v = Vocab.fromMap(vMap);
        if (v != null && v.id != null) {
          vocabsMap[v.id] = v.copyWith(id: null);
        }
      }

      if (map['box'] != null) {
        box = Box.fromMap(map['box']);
        lang ??= box.lang;
        hasFormen = box.hasFormen;
      }

      // if (lang == null || !langs.contains(lang)) {
      //   langs ??= (await options.getOption('langs'))?.cast<String>() ?? ['en'];
      //     lang = langs.first;

      // }

      if (hasFormen == null) {
        for (var v in vocabs) {
          if (v.forms != null) {
            hasFormen = true;
            break;
          }
        }
        hasFormen ??= false;
      }

      isLoaded = true;
    } on UnsupportedError {
      errorText = 'Please select a .vocab file!';
    } catch (err) {
      errorText = 'The format of the file is invalid. Please try again';
      print(err);
    }
  }

  @action
  Future<List<Vocab>> save() async {
    for (var key in vocabsMap.keys) {
      final v = vocabsMap[key];
      final id = await vocabRepo.addVocab(v.copyWith(id: null), lang);
      vocabsMap[key] = v.copyWith(id: id);
    }

    if (box != null && importBox) {
      var com = box.compartments;

      if (com.isEmpty) {
        com = [
          [],
          [],
          [],
          [],
          vocabsMap.values
              .map((v) => VocabCard(id: v.id, beated: 0, failed: 0))
              .toList()
        ];
      } else {
        // go through each com and update ids
        for (var c in com) {
          c = c.map((v) => v.copyWith(id: vocabsMap[v.id].id)).toList();
        }
      }

      print(vocabs.map((e) => e.id).toList());

      box = box.copyWith(
        compartments: com,
        lang: lang,
        hasFormen: hasFormen,
        vocabIds: vocabsMap.values.map((e) => e.id).toList(),
        latest: DateTime.now(),
      );

      await boxRepo.addNewBox(box);
    }

    return vocabs;
  }
}
