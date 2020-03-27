// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabs_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VocabsController on _VocabsControllerBase, Store {
  final _$langsAtom = Atom(name: '_VocabsControllerBase.langs');

  @override
  List<String> get langs {
    _$langsAtom.context.enforceReadPolicy(_$langsAtom);
    _$langsAtom.reportObserved();
    return super.langs;
  }

  @override
  set langs(List<String> value) {
    _$langsAtom.context.conditionallyRunInAction(() {
      super.langs = value;
      _$langsAtom.reportChanged();
    }, _$langsAtom, name: '${_$langsAtom.name}_set');
  }

  final _$selectedLangAtom = Atom(name: '_VocabsControllerBase.selectedLang');

  @override
  String get selectedLang {
    _$selectedLangAtom.context.enforceReadPolicy(_$selectedLangAtom);
    _$selectedLangAtom.reportObserved();
    return super.selectedLang;
  }

  @override
  set selectedLang(String value) {
    _$selectedLangAtom.context.conditionallyRunInAction(() {
      super.selectedLang = value;
      _$selectedLangAtom.reportChanged();
    }, _$selectedLangAtom, name: '${_$selectedLangAtom.name}_set');
  }

  final _$vocabStateAtom = Atom(name: '_VocabsControllerBase.vocabState');

  @override
  LoadingState get vocabState {
    _$vocabStateAtom.context.enforceReadPolicy(_$vocabStateAtom);
    _$vocabStateAtom.reportObserved();
    return super.vocabState;
  }

  @override
  set vocabState(LoadingState value) {
    _$vocabStateAtom.context.conditionallyRunInAction(() {
      super.vocabState = value;
      _$vocabStateAtom.reportChanged();
    }, _$vocabStateAtom, name: '${_$vocabStateAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_VocabsControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$vocabsAtom = Atom(name: '_VocabsControllerBase.vocabs');

  @override
  List<Vocab> get vocabs {
    _$vocabsAtom.context.enforceReadPolicy(_$vocabsAtom);
    _$vocabsAtom.reportObserved();
    return super.vocabs;
  }

  @override
  set vocabs(List<Vocab> value) {
    _$vocabsAtom.context.conditionallyRunInAction(() {
      super.vocabs = value;
      _$vocabsAtom.reportChanged();
    }, _$vocabsAtom, name: '${_$vocabsAtom.name}_set');
  }

  final _$displayedVocabsAtom =
      Atom(name: '_VocabsControllerBase.displayedVocabs');

  @override
  ObservableList<Vocab> get displayedVocabs {
    _$displayedVocabsAtom.context.enforceReadPolicy(_$displayedVocabsAtom);
    _$displayedVocabsAtom.reportObserved();
    return super.displayedVocabs;
  }

  @override
  set displayedVocabs(ObservableList<Vocab> value) {
    _$displayedVocabsAtom.context.conditionallyRunInAction(() {
      super.displayedVocabs = value;
      _$displayedVocabsAtom.reportChanged();
    }, _$displayedVocabsAtom, name: '${_$displayedVocabsAtom.name}_set');
  }

  final _$showFormsAtom = Atom(name: '_VocabsControllerBase.showForms');

  @override
  bool get showForms {
    _$showFormsAtom.context.enforceReadPolicy(_$showFormsAtom);
    _$showFormsAtom.reportObserved();
    return super.showForms;
  }

  @override
  set showForms(bool value) {
    _$showFormsAtom.context.conditionallyRunInAction(() {
      super.showForms = value;
      _$showFormsAtom.reportChanged();
    }, _$showFormsAtom, name: '${_$showFormsAtom.name}_set');
  }

  final _$loadLangsAsyncAction = AsyncAction('loadLangs');

  @override
  Future<dynamic> loadLangs() {
    return _$loadLangsAsyncAction.run(() => super.loadLangs());
  }

  final _$loadVocabsAsyncAction = AsyncAction('loadVocabs');

  @override
  Future<dynamic> loadVocabs() {
    return _$loadVocabsAsyncAction.run(() => super.loadVocabs());
  }

  final _$saveVocabAsyncAction = AsyncAction('saveVocab');

  @override
  Future<dynamic> saveVocab(int id, Vocab v) {
    return _$saveVocabAsyncAction.run(() => super.saveVocab(id, v));
  }

  final _$_VocabsControllerBaseActionController =
      ActionController(name: '_VocabsControllerBase');

  @override
  void searchVocabs(String s) {
    final _$actionInfo = _$_VocabsControllerBaseActionController.startAction();
    try {
      return super.searchVocabs(s);
    } finally {
      _$_VocabsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addVocabs(List<Vocab> vs, String search) {
    final _$actionInfo = _$_VocabsControllerBaseActionController.startAction();
    try {
      return super.addVocabs(vs, search);
    } finally {
      _$_VocabsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'langs: ${langs.toString()},selectedLang: ${selectedLang.toString()},vocabState: ${vocabState.toString()},isLoading: ${isLoading.toString()},vocabs: ${vocabs.toString()},displayedVocabs: ${displayedVocabs.toString()},showForms: ${showForms.toString()}';
    return '{$string}';
  }
}
