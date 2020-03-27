// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BoxController on _BoxControllerBase, Store {
  final _$boxAtom = Atom(name: '_BoxControllerBase.box');

  @override
  Box get box {
    _$boxAtom.context.enforceReadPolicy(_$boxAtom);
    _$boxAtom.reportObserved();
    return super.box;
  }

  @override
  set box(Box value) {
    _$boxAtom.context.conditionallyRunInAction(() {
      super.box = value;
      _$boxAtom.reportChanged();
    }, _$boxAtom, name: '${_$boxAtom.name}_set');
  }

  final _$comAtom = Atom(name: '_BoxControllerBase.com');

  @override
  ObservableList<ObservableList<VocabCard>> get com {
    _$comAtom.context.enforceReadPolicy(_$comAtom);
    _$comAtom.reportObserved();
    return super.com;
  }

  @override
  set com(ObservableList<ObservableList<VocabCard>> value) {
    _$comAtom.context.conditionallyRunInAction(() {
      super.com = value;
      _$comAtom.reportChanged();
    }, _$comAtom, name: '${_$comAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_BoxControllerBase.isLoading');

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

  final _$vocabStateAtom = Atom(name: '_BoxControllerBase.vocabState');

  @override
  VocabState get vocabState {
    _$vocabStateAtom.context.enforceReadPolicy(_$vocabStateAtom);
    _$vocabStateAtom.reportObserved();
    return super.vocabState;
  }

  @override
  set vocabState(VocabState value) {
    _$vocabStateAtom.context.conditionallyRunInAction(() {
      super.vocabState = value;
      _$vocabStateAtom.reportChanged();
    }, _$vocabStateAtom, name: '${_$vocabStateAtom.name}_set');
  }

  final _$selectedCompartmentAtom =
      Atom(name: '_BoxControllerBase.selectedCompartment');

  @override
  int get selectedCompartment {
    _$selectedCompartmentAtom.context
        .enforceReadPolicy(_$selectedCompartmentAtom);
    _$selectedCompartmentAtom.reportObserved();
    return super.selectedCompartment;
  }

  @override
  set selectedCompartment(int value) {
    _$selectedCompartmentAtom.context.conditionallyRunInAction(() {
      super.selectedCompartment = value;
      _$selectedCompartmentAtom.reportChanged();
    }, _$selectedCompartmentAtom,
        name: '${_$selectedCompartmentAtom.name}_set');
  }

  final _$inputRightAtom = Atom(name: '_BoxControllerBase.inputRight');

  @override
  bool get inputRight {
    _$inputRightAtom.context.enforceReadPolicy(_$inputRightAtom);
    _$inputRightAtom.reportObserved();
    return super.inputRight;
  }

  @override
  set inputRight(bool value) {
    _$inputRightAtom.context.conditionallyRunInAction(() {
      super.inputRight = value;
      _$inputRightAtom.reportChanged();
    }, _$inputRightAtom, name: '${_$inputRightAtom.name}_set');
  }

  final _$formsRightAtom = Atom(name: '_BoxControllerBase.formsRight');

  @override
  bool get formsRight {
    _$formsRightAtom.context.enforceReadPolicy(_$formsRightAtom);
    _$formsRightAtom.reportObserved();
    return super.formsRight;
  }

  @override
  set formsRight(bool value) {
    _$formsRightAtom.context.conditionallyRunInAction(() {
      super.formsRight = value;
      _$formsRightAtom.reportChanged();
    }, _$formsRightAtom, name: '${_$formsRightAtom.name}_set');
  }

  final _$loadVocabAsyncAction = AsyncAction('loadVocab');

  @override
  Future<dynamic> loadVocab(VocabCard v) {
    return _$loadVocabAsyncAction.run(() => super.loadVocab(v));
  }

  final _$_BoxControllerBaseActionController =
      ActionController(name: '_BoxControllerBase');

  @override
  void next(
      {bool input,
      bool loadNextTab = false,
      void Function(int) onTabSelected}) {
    final _$actionInfo = _$_BoxControllerBaseActionController.startAction();
    try {
      return super.next(
          input: input, loadNextTab: loadNextTab, onTabSelected: onTabSelected);
    } finally {
      _$_BoxControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void checkInputs(String input, String forms) {
    final _$actionInfo = _$_BoxControllerBaseActionController.startAction();
    try {
      return super.checkInputs(input, forms);
    } finally {
      _$_BoxControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'box: ${box.toString()},com: ${com.toString()},isLoading: ${isLoading.toString()},vocabState: ${vocabState.toString()},selectedCompartment: ${selectedCompartment.toString()},inputRight: ${inputRight.toString()},formsRight: ${formsRight.toString()}';
    return '{$string}';
  }
}
