// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'results_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResultsController on _ResultsControllerBase, Store {
  Computed<int> _$totalPointsComputed;

  @override
  int get totalPoints =>
      (_$totalPointsComputed ??= Computed<int>(() => super.totalPoints)).value;
  Computed<double> _$pointsComputed;

  @override
  double get points =>
      (_$pointsComputed ??= Computed<double>(() => super.points)).value;
  Computed<double> _$percentageComputed;

  @override
  double get percentage =>
      (_$percentageComputed ??= Computed<double>(() => super.percentage)).value;
  Computed<String> _$gradeComputed;

  @override
  String get grade =>
      (_$gradeComputed ??= Computed<String>(() => super.grade)).value;

  final _$isLoadingAtom = Atom(name: '_ResultsControllerBase.isLoading');

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

  final _$expandedCardAtom = Atom(name: '_ResultsControllerBase.expandedCard');

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

  final _$vocabsAtom = Atom(name: '_ResultsControllerBase.vocabs');

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

  final _$mistakesAtom = Atom(name: '_ResultsControllerBase.mistakes');

  @override
  double get mistakes {
    _$mistakesAtom.context.enforceReadPolicy(_$mistakesAtom);
    _$mistakesAtom.reportObserved();
    return super.mistakes;
  }

  @override
  set mistakes(double value) {
    _$mistakesAtom.context.conditionallyRunInAction(() {
      super.mistakes = value;
      _$mistakesAtom.reportChanged();
    }, _$mistakesAtom, name: '${_$mistakesAtom.name}_set');
  }

  final _$calculateResultsAsyncAction = AsyncAction('calculateResults');

  @override
  Future<dynamic> calculateResults(int id, ObservableList<VocabTestValue> v) {
    return _$calculateResultsAsyncAction
        .run(() => super.calculateResults(id, v));
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},expandedCard: ${expandedCard.toString()},vocabs: ${vocabs.toString()},mistakes: ${mistakes.toString()},totalPoints: ${totalPoints.toString()},points: ${points.toString()},percentage: ${percentage.toString()},grade: ${grade.toString()}';
    return '{$string}';
  }
}
