// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocab_test_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VocabTestController on _VocabTestControllerBase, Store {
  Computed<int> _$lengthComputed;

  @override
  int get length =>
      (_$lengthComputed ??= Computed<int>(() => super.length)).value;

  final _$isLoadingAtom = Atom(name: '_VocabTestControllerBase.isLoading');

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

  final _$selectedPageAtom =
      Atom(name: '_VocabTestControllerBase.selectedPage');

  @override
  int get selectedPage {
    _$selectedPageAtom.context.enforceReadPolicy(_$selectedPageAtom);
    _$selectedPageAtom.reportObserved();
    return super.selectedPage;
  }

  @override
  set selectedPage(int value) {
    _$selectedPageAtom.context.conditionallyRunInAction(() {
      super.selectedPage = value;
      _$selectedPageAtom.reportChanged();
    }, _$selectedPageAtom, name: '${_$selectedPageAtom.name}_set');
  }

  final _$vocabsAtom = Atom(name: '_VocabTestControllerBase.vocabs');

  @override
  ObservableList<VocabTestValue> get vocabs {
    _$vocabsAtom.context.enforceReadPolicy(_$vocabsAtom);
    _$vocabsAtom.reportObserved();
    return super.vocabs;
  }

  @override
  set vocabs(ObservableList<VocabTestValue> value) {
    _$vocabsAtom.context.conditionallyRunInAction(() {
      super.vocabs = value;
      _$vocabsAtom.reportChanged();
    }, _$vocabsAtom, name: '${_$vocabsAtom.name}_set');
  }

  final _$_VocabTestControllerBaseActionController =
      ActionController(name: '_VocabTestControllerBase');

  @override
  void applyAnswer(int index, String answer, String forms) {
    final _$actionInfo =
        _$_VocabTestControllerBaseActionController.startAction();
    try {
      return super.applyAnswer(index, answer, forms);
    } finally {
      _$_VocabTestControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},selectedPage: ${selectedPage.toString()},vocabs: ${vocabs.toString()},length: ${length.toString()}';
    return '{$string}';
  }
}
