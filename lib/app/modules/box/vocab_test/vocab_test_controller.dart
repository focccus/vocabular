import 'package:mobx/mobx.dart';
import 'package:vocabular/app/models/box.dart';

import 'package:vocabular/app/repositories/box_repository.dart';
import 'package:vocabular/app/repositories/vocab_repository.dart';

import 'vocab_value.dart';

part 'vocab_test_controller.g.dart';

class VocabTestController = _VocabTestControllerBase with _$VocabTestController;

abstract class _VocabTestControllerBase with Store {
  int boxID;

  final BoxRepository storage;
  final VocabRepository vocabStore;

  _VocabTestControllerBase(this.storage, this.vocabStore);

  Box box;

  @observable
  bool isLoading = true;

  Future<Box> loadBox(int id) async {
    isLoading = true;
    if (id == null) return null;
    boxID = id;
    box = await storage.getBoxByID(boxID);
    if (box != null && box.vocabIds != null && box.vocabIds.isNotEmpty) {
      List<int> ids = List.from(box.vocabIds);
      ids.shuffle();
      if (box.testCount >= 0) {
        ids = ids.skip(box.vocabIds.length - box.testCount).toList();
      }

      vocabs = ObservableList.of(
        (await vocabStore.getVocabs(ids, box.lang)).map(
          (e) => VocabTestValue(vocab: e, input: '', inputForms: ''),
        ),
      );
      isLoading = false;
    }

    return box;
  }

  @observable
  int selectedPage = 0;

  @observable
  ObservableList<VocabTestValue> vocabs;

  @action
  void applyAnswer(int index, String answer, String forms) {
    print('saved $index');
    vocabs[index] = vocabs[index].copyWith(input: answer, inputForms: forms);
  }

  @computed
  int get length => vocabs?.length ?? 0;
}
