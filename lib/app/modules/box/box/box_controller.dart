import 'package:mobx/mobx.dart';
import 'package:vocabular/app/models/box.dart';
import 'package:vocabular/app/models/vocab.dart';
import 'package:vocabular/app/repositories/box_repository.dart';
import 'package:vocabular/app/repositories/string_similarity.dart';
import 'package:vocabular/app/repositories/vocab_repository.dart';

part 'box_controller.g.dart';

class BoxController = _BoxControllerBase with _$BoxController;

abstract class _BoxControllerBase with Store {
  int boxID;

  final BoxRepository storage;
  final VocabRepository vocabStore;

  _BoxControllerBase(this.storage, this.vocabStore);

  @observable
  Box box;

  @observable
  ObservableList<ObservableList<VocabCard>> com;

  @observable
  bool isLoading = true;

  @observable
  VocabState vocabState = VocabState.loading;

  @observable
  int selectedCompartment;

  Vocab currentVocabData;
  VocabCard currentVocab;

  Future<Box> loadBox(int id) async {
    isLoading = true;
    if (id == null) return null;
    boxID = id;
    box = await storage.getBoxByID(boxID);
    if (box != null &&
        box.compartments != null &&
        box.compartments.isNotEmpty) {
      isLoading = false;

      // set compartments
      com = ObservableList.of(
        box.compartments.map((e) => ObservableList.of(e)).toList(),
      );

      // shuffle compartments
      if (box.random) {
        com.forEach((list) {
          list.shuffle();
        });
      }

      // load the first vocab and set the tab

      selectedCompartment = com.length - 1;

      next(loadNextTab: true);
    }
    return box;
  }

  void setSelected(int index) {
    selectedCompartment = index;
    next();
  }

  @action
  void next({
    bool input,
    bool loadNextTab = false,
    void Function(int) onTabSelected,
  }) {
    // move the last vocab depending on input
    if (input != null && currentVocab != null) {
      if (input && selectedCompartment - 1 >= 0) {
        com[selectedCompartment - 1].add(
          currentVocab.copyWith(beated: (currentVocab?.beated ?? 0) + 1),
        );
        com[selectedCompartment].remove(currentVocab);
      }
      if (!input) {
        // try all boxes up to goback
        for (var i = box.goback; i >= 0; i--) {
          if (selectedCompartment + i < com.length) {
            // add the vocab to the best box
            com[selectedCompartment + i].add(
              currentVocab.copyWith(failed: (currentVocab?.failed ?? 0) + 1),
            );
            break;
          }
        }

        com[selectedCompartment].remove(currentVocab);
      }

      // save box
      storage.saveBox(box.copyWith(compartments: com), box.id);
    }

    // load the next one
    if (loadNextTab && com[selectedCompartment].isEmpty) {
      final prevTab = selectedCompartment;
      // select the next smaller
      for (var i = prevTab; i >= 0; i--) {
        if (com[i].isNotEmpty) {
          selectedCompartment = i;
          break;
        }
      }
      // the next one is still empty? Search the other way
      if (com[selectedCompartment].isEmpty) {
        for (var i = prevTab; i < com.length; i++) {
          if (com[i].isNotEmpty) {
            selectedCompartment = i;
            break;
          }
        }
      }

      // notify possible listener about change

      if (onTabSelected != null && prevTab != selectedCompartment) {
        onTabSelected(selectedCompartment);
      }
    }

    if (com[selectedCompartment].isEmpty) {
      vocabState = VocabState.empty;
    } else {
      // load first vocab

      loadVocab(com[selectedCompartment].first);
    }
  }

  @action
  Future loadVocab(VocabCard v) async {
    vocabState = VocabState.loading;

    if (v == null) {
      vocabState = VocabState.empty;
    } else {
      currentVocab = v;
      currentVocabData = await vocabStore.getVocabByID(v.id, box.lang);

      if (currentVocabData == null) {
        vocabState = VocabState.empty;
        com[selectedCompartment].remove(currentVocab);
        storage.saveBox(box.copyWith(compartments: com), box.id);
        next();
      } else {
        vocabState = VocabState.loaded;
      }
    }
  }

  @observable
  bool inputRight = false;

  @observable
  bool formsRight = false;

  @action
  void checkInputs(String input, String forms) {
    inputRight = StringSimilarity.checkSimilarity(
      input,
      box.askForeign ? currentVocabData.other : currentVocabData.main,
    );
    formsRight = box.hasFormen
        ? StringSimilarity.checkSimilarity(
            forms,
            currentVocabData.forms,
          )
        : true;

    vocabState = VocabState.checked;
  }
}

enum VocabState {
  loading,
  empty,
  loaded,
  checked,
}
