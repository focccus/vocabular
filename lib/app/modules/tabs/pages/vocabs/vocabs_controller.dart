import 'package:mobx/mobx.dart';
import 'package:vocabular/app/models/vocab.dart';
import 'package:vocabular/app/repositories/box_repository.dart';
import 'package:vocabular/app/repositories/options_repository.dart';
import 'package:vocabular/app/repositories/vocab_repository.dart';

part 'vocabs_controller.g.dart';

class VocabsController = _VocabsControllerBase with _$VocabsController;

abstract class _VocabsControllerBase with Store {
  final VocabRepository repo;
  final OptionsRepository options;

  _VocabsControllerBase(this.repo, this.options);

  @observable
  List<String> langs;

  @observable
  String selectedLang;

  @observable
  LoadingState vocabState = LoadingState.initial;

  @observable
  bool isLoading = true;

  @action
  Future loadLangs() async {
    isLoading = true;
    langs = (await options.getOption('langs') ?? ['en']).cast<String>();
    selectedLang = langs.first;
    isLoading = false;
    loadVocabs();
  }

  @observable
  List<Vocab> vocabs;

  @observable
  ObservableList<Vocab> displayedVocabs;

  @observable
  bool showForms = false;

  @action
  Future loadVocabs() async {
    vocabState = LoadingState.loading;

    try {
      vocabs = ObservableList.of(await repo.getAllVocabs(selectedLang));
      searchVocabs(null);

      if (vocabs.isEmpty)
        vocabState = LoadingState.empty;
      else {
        vocabState = LoadingState.loaded;
        if (vocabs.length > 100)
          showForms = true;
        else {
          for (var v in vocabs) {
            if (v.forms != null && v.forms.isNotEmpty) {
              showForms = true;
              break;
            }
          }
        }
      }
    } catch (err) {
      vocabState = LoadingState.empty;
    }
  }

  @action
  void searchVocabs(String s) {
    if (s != null && s.isNotEmpty) {
      s = s.toLowerCase();

      displayedVocabs = ObservableList.of(
        vocabs
            .where((v) =>
                v.main.toLowerCase().contains(s) ||
                v.other.toLowerCase().contains(s))
            .toList(),
      );
    } else {
      displayedVocabs = ObservableList.of(vocabs);
    }
    if (displayedVocabs.isEmpty) {
      vocabState = LoadingState.empty;
    } else if (vocabState != LoadingState.loaded) {
      vocabState = LoadingState.loaded;
    }
  }

  @action
  void addVocabs(List<Vocab> vs, String search) {
    vocabs.addAll(vs);
    searchVocabs(search);
  }

  @action
  Future saveVocab(int id, Vocab v) async {
    if (vocabState == LoadingState.empty) vocabState = LoadingState.loaded;
    if (v.id != null && id != null) {
      // save existing

      final index = vocabs.indexWhere((element) => element.id == id);

      if (v.id == -1) {
        // delete vocab
        vocabs.removeAt(index);

        await repo.deleteVocab(id, selectedLang);
        if (vocabs.isEmpty) vocabState = LoadingState.empty;
      } else if (id != v.id) {
        // vocab reference changed
        // this is not possible in vocablist
      } else {
        // vocab changed
        if (index >= 0) vocabs[index] = v;

        repo.saveVocab(v, id, selectedLang);
      }
    } else {
      // add new vocab
      final newId = await repo.addVocab(v, selectedLang);

      v = v.copyWith(id: newId);
      vocabs = ObservableList.of([...vocabs, v]);
    }
  }
}
