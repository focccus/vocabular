// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ExportController on _ExportControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_ExportControllerBase.isLoading');

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

  final _$vocabsAtom = Atom(name: '_ExportControllerBase.vocabs');

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

  final _$selectedAtom = Atom(name: '_ExportControllerBase.selected');

  @override
  ObservableSet<Vocab> get selected {
    _$selectedAtom.context.enforceReadPolicy(_$selectedAtom);
    _$selectedAtom.reportObserved();
    return super.selected;
  }

  @override
  set selected(ObservableSet<Vocab> value) {
    _$selectedAtom.context.conditionallyRunInAction(() {
      super.selected = value;
      _$selectedAtom.reportChanged();
    }, _$selectedAtom, name: '${_$selectedAtom.name}_set');
  }

  final _$justExportVocabsAtom =
      Atom(name: '_ExportControllerBase.justExportVocabs');

  @override
  bool get justExportVocabs {
    _$justExportVocabsAtom.context.enforceReadPolicy(_$justExportVocabsAtom);
    _$justExportVocabsAtom.reportObserved();
    return super.justExportVocabs;
  }

  @override
  set justExportVocabs(bool value) {
    _$justExportVocabsAtom.context.conditionallyRunInAction(() {
      super.justExportVocabs = value;
      _$justExportVocabsAtom.reportChanged();
    }, _$justExportVocabsAtom, name: '${_$justExportVocabsAtom.name}_set');
  }

  final _$includeCompartmentsAtom =
      Atom(name: '_ExportControllerBase.includeCompartments');

  @override
  bool get includeCompartments {
    _$includeCompartmentsAtom.context
        .enforceReadPolicy(_$includeCompartmentsAtom);
    _$includeCompartmentsAtom.reportObserved();
    return super.includeCompartments;
  }

  @override
  set includeCompartments(bool value) {
    _$includeCompartmentsAtom.context.conditionallyRunInAction(() {
      super.includeCompartments = value;
      _$includeCompartmentsAtom.reportChanged();
    }, _$includeCompartmentsAtom,
        name: '${_$includeCompartmentsAtom.name}_set');
  }

  final _$_ExportControllerBaseActionController =
      ActionController(name: '_ExportControllerBase');

  @override
  void select(Vocab v) {
    final _$actionInfo = _$_ExportControllerBaseActionController.startAction();
    try {
      return super.select(v);
    } finally {
      _$_ExportControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},vocabs: ${vocabs.toString()},selected: ${selected.toString()},justExportVocabs: ${justExportVocabs.toString()},includeCompartments: ${includeCompartments.toString()}';
    return '{$string}';
  }
}
