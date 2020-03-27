import 'package:mobx/mobx.dart';
import 'package:vocabular/app/models/box.dart';
import 'package:vocabular/app/repositories/box_repository.dart';
import 'package:vocabular/app/repositories/grade_tables.dart';
import 'package:vocabular/app/repositories/options_repository.dart';
import 'package:vocabular/app/repositories/string_similarity.dart';

import '../vocab_value.dart';

part 'results_controller.g.dart';

class ResultsController = _ResultsControllerBase with _$ResultsController;

abstract class _ResultsControllerBase with Store {
  int boxID;

  final BoxRepository storage;
  final OptionsRepository options;

  _ResultsControllerBase(this.storage, this.options);

  Box box;

  String grades = 'de';

  @observable
  bool isLoading = true;

  @observable
  int expandedCard = -1;

  @observable
  ObservableList<VocabTestValue> vocabs;

  @observable
  double mistakes = 0;

  @computed
  int get totalPoints => box.hasFormen ? vocabs.length * 2 : vocabs.length;

  @computed
  double get points => totalPoints - mistakes;

  @computed
  double get percentage => points / totalPoints;

  @computed
  String get grade {
    switch (grades) {
      case 'us':
        return GradeTable.american(percentage);
      case 'ob':
        return GradeTable.oberstufe(percentage);
      default:
        return GradeTable.german(percentage);
    }
  }

  @action
  Future calculateResults(int id, ObservableList<VocabTestValue> v) async {
    isLoading = true;

    boxID = id;

    box = await storage.getBoxByID(boxID);

    grades = await options.getOption('grades') ?? 'de';

    vocabs = v;

    for (var vocab in vocabs) {
      final index = vocabs.indexOf(vocab);
      final val = StringSimilarity.checkClosest(
        vocab.input ?? '',
        box.getDisplayText(vocab.vocab, true),
      );

      int formsVal = 0;

      if (box.hasFormen) {
        formsVal = StringSimilarity.checkClosest(
          vocab.inputForms ?? '',
          vocab.vocab.forms,
        );
      }

      vocab = vocab.copyWith(
        valueMistakes: val > 2 ? 2 : val,
        formsMistakes: formsVal > 2 ? 2 : formsVal,
      );

      mistakes += vocab.mistakes;
      vocabs[index] = vocab;
    }

    isLoading = false;
  }
}
