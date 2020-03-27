import 'package:mobx/mobx.dart';
import 'package:vocabular/app/models/box.dart';
import 'package:vocabular/app/models/vocab.dart';
import 'package:vocabular/app/repositories/box_repository.dart';
import 'package:vocabular/app/repositories/vocab_repository.dart';

part 'box_list_controller.g.dart';

class BoxListController = _BoxListControllerBase with _$BoxListController;

abstract class _BoxListControllerBase with Store {
  int boxID;

  final BoxRepository storage;
  final VocabRepository vocabStore;

  _BoxListControllerBase(this.storage, this.vocabStore);

  Box box;

  @observable
  LoadingState status = LoadingState.initial;

  @observable
  ObservableList<Vocab> vocabs = ObservableList.of([]);

  Future<Box> loadBox(int id) async {
    status = LoadingState.loading;
    if (id == null) return null;
    boxID = id;
    box = await storage.getBoxByID(boxID);
    if (box != null && box.vocabIds != null && box.vocabIds.isNotEmpty) {
      status = LoadingState.loaded;
      vocabs = ObservableList.of(
        await vocabStore.getVocabs(box.vocabIds, box.lang),
      );
      // if empty ones exist delete
      for (var i = 0; i < vocabs.length; i++) {
        if (vocabs[i] == null) {
          // delete vocab
          deleteVocab(box.vocabIds[i], i);
        }
      }
    } else {
      status = LoadingState.empty;
    }
    return box;
  }

  @action
  void importVocabs(List<Vocab> newVocabs) {
    vocabs.addAll(newVocabs);

    final ids = newVocabs.map((v) => v.id);

    box.vocabIds.addAll(ids);
    box.compartments.last.addAll(
      ids.map((v) => VocabCard(id: v, failed: 0, beated: 0)),
    );
    if (vocabs.isNotEmpty) status = LoadingState.loaded;

    storage.saveBox(box, boxID);
  }

  Future deleteVocab(int id, int index) async {
    vocabs.removeAt(index);
    box.vocabIds.remove(id);
    box.compartments.forEach((c) => c.removeWhere((card) => card.id == id));

    await storage.saveBox(box, boxID);
    if (vocabs.isEmpty) status = LoadingState.empty;
  }

  @action
  Future saveVocab(int id, Vocab v) async {
    if (status == LoadingState.empty) status = LoadingState.loaded;
    if (v.id != null && id != null) {
      // save existing

      final index = vocabs.indexWhere((element) => element.id == id);

      if (v.id == -1) {
        // delete vocab
        deleteVocab(id, index);
      } else if (id != v.id) {
        // vocab reference changed
        vocabs[index] = v;
        box.vocabIds[index] = v.id;

        for (var com in box.compartments) {
          for (var vocab in com) {
            if (vocab.id == id) {
              com[com.indexOf(vocab)] = vocab.copyWith(id: v.id);
              break;
            }
          }
        }

        await storage.saveBox(box, boxID);
      } else {
        // vocab changed
        if (index >= 0) vocabs[index] = v;

        vocabStore.saveVocab(v, id, box.lang);
      }
    } else {
      // add new vocab
      final newId = await vocabStore.addVocab(v, box.lang);

      v = v.copyWith(id: newId);
      vocabs = ObservableList.of([...vocabs, v]);

      // modify box
      box.compartments.last.add(VocabCard(id: newId, beated: 0, failed: 0));
      box = box.copyWith(vocabIds: [...box.vocabIds, newId]);
      await storage.saveBox(box, boxID);
    }
  }
}
