// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box_list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BoxListController on _BoxListControllerBase, Store {
  final _$statusAtom = Atom(name: '_BoxListControllerBase.status');

  @override
  LoadingState get status {
    _$statusAtom.context.enforceReadPolicy(_$statusAtom);
    _$statusAtom.reportObserved();
    return super.status;
  }

  @override
  set status(LoadingState value) {
    _$statusAtom.context.conditionallyRunInAction(() {
      super.status = value;
      _$statusAtom.reportChanged();
    }, _$statusAtom, name: '${_$statusAtom.name}_set');
  }

  final _$vocabsAtom = Atom(name: '_BoxListControllerBase.vocabs');

  @override
  ObservableList<Vocab> get vocabs {
    _$vocabsAtom.context.enforceReadPolicy(_$vocabsAtom);
    _$vocabsAtom.reportObserved();
    return super.vocabs;
  }

  @override
  set vocabs(ObservableList<Vocab> value) {
    _$vocabsAtom.context.conditionallyRunInAction(() {
      super.vocabs = value;
      _$vocabsAtom.reportChanged();
    }, _$vocabsAtom, name: '${_$vocabsAtom.name}_set');
  }

  final _$saveVocabAsyncAction = AsyncAction('saveVocab');

  @override
  Future<dynamic> saveVocab(int id, Vocab v) {
    return _$saveVocabAsyncAction.run(() => super.saveVocab(id, v));
  }

  final _$_BoxListControllerBaseActionController =
      ActionController(name: '_BoxListControllerBase');

  @override
  void importVocabs(List<Vocab> newVocabs) {
    final _$actionInfo = _$_BoxListControllerBaseActionController.startAction();
    try {
      return super.importVocabs(newVocabs);
    } finally {
      _$_BoxListControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'status: ${status.toString()},vocabs: ${vocabs.toString()}';
    return '{$string}';
  }
}
