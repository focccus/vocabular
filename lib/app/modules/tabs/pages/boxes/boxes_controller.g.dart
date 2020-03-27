// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boxes_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BoxesController on _BoxesControllerBase, Store {
  Computed<LoadingState> _$stateComputed;

  @override
  LoadingState get state =>
      (_$stateComputed ??= Computed<LoadingState>(() => super.state)).value;

  final _$expandedCardAtom = Atom(name: '_BoxesControllerBase.expandedCard');

  @override
  int get expandedCard {
    _$expandedCardAtom.context.enforceReadPolicy(_$expandedCardAtom);
    _$expandedCardAtom.reportObserved();
    return super.expandedCard;
  }

  @override
  set expandedCard(int value) {
    _$expandedCardAtom.context.conditionallyRunInAction(() {
      super.expandedCard = value;
      _$expandedCardAtom.reportChanged();
    }, _$expandedCardAtom, name: '${_$expandedCardAtom.name}_set');
  }

  final _$boxesAtom = Atom(name: '_BoxesControllerBase.boxes');

  @override
  ObservableList<Box> get boxes {
    _$boxesAtom.context.enforceReadPolicy(_$boxesAtom);
    _$boxesAtom.reportObserved();
    return super.boxes;
  }

  @override
  set boxes(ObservableList<Box> value) {
    _$boxesAtom.context.conditionallyRunInAction(() {
      super.boxes = value;
      _$boxesAtom.reportChanged();
    }, _$boxesAtom, name: '${_$boxesAtom.name}_set');
  }

  final _$boxesFutureAtom = Atom(name: '_BoxesControllerBase.boxesFuture');

  @override
  ObservableFuture<List<Box>> get boxesFuture {
    _$boxesFutureAtom.context.enforceReadPolicy(_$boxesFutureAtom);
    _$boxesFutureAtom.reportObserved();
    return super.boxesFuture;
  }

  @override
  set boxesFuture(ObservableFuture<List<Box>> value) {
    _$boxesFutureAtom.context.conditionallyRunInAction(() {
      super.boxesFuture = value;
      _$boxesFutureAtom.reportChanged();
    }, _$boxesFutureAtom, name: '${_$boxesFutureAtom.name}_set');
  }

  final _$loadBoxesAsyncAction = AsyncAction('loadBoxes');

  @override
  Future<dynamic> loadBoxes() {
    return _$loadBoxesAsyncAction.run(() => super.loadBoxes());
  }

  final _$addBoxAsyncAction = AsyncAction('addBox');

  @override
  Future<dynamic> addBox() {
    return _$addBoxAsyncAction.run(() => super.addBox());
  }

  @override
  String toString() {
    final string =
        'expandedCard: ${expandedCard.toString()},boxes: ${boxes.toString()},boxesFuture: ${boxesFuture.toString()},state: ${state.toString()}';
    return '{$string}';
  }
}
