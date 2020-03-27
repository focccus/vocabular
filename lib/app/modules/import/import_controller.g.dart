// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'import_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImportController on _ImportControllerBase, Store {
  Computed<List<Vocab>> _$vocabsComputed;

  @override
  List<Vocab> get vocabs =>
      (_$vocabsComputed ??= Computed<List<Vocab>>(() => super.vocabs)).value;

  final _$errorTextAtom = Atom(name: '_ImportControllerBase.errorText');

  @override
  String get errorText {
    _$errorTextAtom.context.enforceReadPolicy(_$errorTextAtom);
    _$errorTextAtom.reportObserved();
    return super.errorText;
  }

  @override
  set errorText(String value) {
    _$errorTextAtom.context.conditionallyRunInAction(() {
      super.errorText = value;
      _$errorTextAtom.reportChanged();
    }, _$errorTextAtom, name: '${_$errorTextAtom.name}_set');
  }

  final _$vocabsMapAtom = Atom(name: '_ImportControllerBase.vocabsMap');

  @override
  Map<int, Vocab> get vocabsMap {
    _$vocabsMapAtom.context.enforceReadPolicy(_$vocabsMapAtom);
    _$vocabsMapAtom.reportObserved();
    return super.vocabsMap;
  }

  @override
  set vocabsMap(Map<int, Vocab> value) {
    _$vocabsMapAtom.context.conditionallyRunInAction(() {
      super.vocabsMap = value;
      _$vocabsMapAtom.reportChanged();
    }, _$vocabsMapAtom, name: '${_$vocabsMapAtom.name}_set');
  }

  final _$isLoadedAtom = Atom(name: '_ImportControllerBase.isLoaded');

  @override
  bool get isLoaded {
    _$isLoadedAtom.context.enforceReadPolicy(_$isLoadedAtom);
    _$isLoadedAtom.reportObserved();
    return super.isLoaded;
  }

  @override
  set isLoaded(bool value) {
    _$isLoadedAtom.context.conditionallyRunInAction(() {
      super.isLoaded = value;
      _$isLoadedAtom.reportChanged();
    }, _$isLoadedAtom, name: '${_$isLoadedAtom.name}_set');
  }

  final _$importBoxAtom = Atom(name: '_ImportControllerBase.importBox');

  @override
  bool get importBox {
    _$importBoxAtom.context.enforceReadPolicy(_$importBoxAtom);
    _$importBoxAtom.reportObserved();
    return super.importBox;
  }

  @override
  set importBox(bool value) {
    _$importBoxAtom.context.conditionallyRunInAction(() {
      super.importBox = value;
      _$importBoxAtom.reportChanged();
    }, _$importBoxAtom, name: '${_$importBoxAtom.name}_set');
  }

  final _$langAtom = Atom(name: '_ImportControllerBase.lang');

  @override
  String get lang {
    _$langAtom.context.enforceReadPolicy(_$langAtom);
    _$langAtom.reportObserved();
    return super.lang;
  }

  @override
  set lang(String value) {
    _$langAtom.context.conditionallyRunInAction(() {
      super.lang = value;
      _$langAtom.reportChanged();
    }, _$langAtom, name: '${_$langAtom.name}_set');
  }

  final _$importFileAsyncAction = AsyncAction('importFile');

  @override
  Future<dynamic> importFile() {
    return _$importFileAsyncAction.run(() => super.importFile());
  }

  final _$saveAsyncAction = AsyncAction('save');

  @override
  Future<List<Vocab>> save() {
    return _$saveAsyncAction.run(() => super.save());
  }

  @override
  String toString() {
    final string =
        'errorText: ${errorText.toString()},vocabsMap: ${vocabsMap.toString()},isLoaded: ${isLoaded.toString()},importBox: ${importBox.toString()},lang: ${lang.toString()},vocabs: ${vocabs.toString()}';
    return '{$string}';
  }
}
