// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box_settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BoxSettingsController on _BoxSettingsControllerBase, Store {
  Computed<List<bool>> _$askLangComputed;

  @override
  List<bool> get askLang =>
      (_$askLangComputed ??= Computed<List<bool>>(() => super.askLang)).value;

  final _$langsAtom = Atom(name: '_BoxSettingsControllerBase.langs');

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

  final _$langAtom = Atom(name: '_BoxSettingsControllerBase.lang');

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

  final _$isLoadingAtom = Atom(name: '_BoxSettingsControllerBase.isLoading');

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

  final _$errorMessageAtom =
      Atom(name: '_BoxSettingsControllerBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$hasFormenAtom = Atom(name: '_BoxSettingsControllerBase.hasFormen');

  @override
  bool get hasFormen {
    _$hasFormenAtom.context.enforceReadPolicy(_$hasFormenAtom);
    _$hasFormenAtom.reportObserved();
    return super.hasFormen;
  }

  @override
  set hasFormen(bool value) {
    _$hasFormenAtom.context.conditionallyRunInAction(() {
      super.hasFormen = value;
      _$hasFormenAtom.reportChanged();
    }, _$hasFormenAtom, name: '${_$hasFormenAtom.name}_set');
  }

  final _$compartmentsAtom =
      Atom(name: '_BoxSettingsControllerBase.compartments');

  @override
  int get compartments {
    _$compartmentsAtom.context.enforceReadPolicy(_$compartmentsAtom);
    _$compartmentsAtom.reportObserved();
    return super.compartments;
  }

  @override
  set compartments(int value) {
    _$compartmentsAtom.context.conditionallyRunInAction(() {
      super.compartments = value;
      _$compartmentsAtom.reportChanged();
    }, _$compartmentsAtom, name: '${_$compartmentsAtom.name}_set');
  }

  final _$gobackAtom = Atom(name: '_BoxSettingsControllerBase.goback');

  @override
  int get goback {
    _$gobackAtom.context.enforceReadPolicy(_$gobackAtom);
    _$gobackAtom.reportObserved();
    return super.goback;
  }

  @override
  set goback(int value) {
    _$gobackAtom.context.conditionallyRunInAction(() {
      super.goback = value;
      _$gobackAtom.reportChanged();
    }, _$gobackAtom, name: '${_$gobackAtom.name}_set');
  }

  final _$mustTypeAtom = Atom(name: '_BoxSettingsControllerBase.mustType');

  @override
  bool get mustType {
    _$mustTypeAtom.context.enforceReadPolicy(_$mustTypeAtom);
    _$mustTypeAtom.reportObserved();
    return super.mustType;
  }

  @override
  set mustType(bool value) {
    _$mustTypeAtom.context.conditionallyRunInAction(() {
      super.mustType = value;
      _$mustTypeAtom.reportChanged();
    }, _$mustTypeAtom, name: '${_$mustTypeAtom.name}_set');
  }

  final _$randomAtom = Atom(name: '_BoxSettingsControllerBase.random');

  @override
  bool get random {
    _$randomAtom.context.enforceReadPolicy(_$randomAtom);
    _$randomAtom.reportObserved();
    return super.random;
  }

  @override
  set random(bool value) {
    _$randomAtom.context.conditionallyRunInAction(() {
      super.random = value;
      _$randomAtom.reportChanged();
    }, _$randomAtom, name: '${_$randomAtom.name}_set');
  }

  final _$askForeignAtom = Atom(name: '_BoxSettingsControllerBase.askForeign');

  @override
  bool get askForeign {
    _$askForeignAtom.context.enforceReadPolicy(_$askForeignAtom);
    _$askForeignAtom.reportObserved();
    return super.askForeign;
  }

  @override
  set askForeign(bool value) {
    _$askForeignAtom.context.conditionallyRunInAction(() {
      super.askForeign = value;
      _$askForeignAtom.reportChanged();
    }, _$askForeignAtom, name: '${_$askForeignAtom.name}_set');
  }

  final _$testCountAtom = Atom(name: '_BoxSettingsControllerBase.testCount');

  @override
  int get testCount {
    _$testCountAtom.context.enforceReadPolicy(_$testCountAtom);
    _$testCountAtom.reportObserved();
    return super.testCount;
  }

  @override
  set testCount(int value) {
    _$testCountAtom.context.conditionallyRunInAction(() {
      super.testCount = value;
      _$testCountAtom.reportChanged();
    }, _$testCountAtom, name: '${_$testCountAtom.name}_set');
  }

  final _$deleteAsyncAction = AsyncAction('delete');

  @override
  Future<dynamic> delete() {
    return _$deleteAsyncAction.run(() => super.delete());
  }

  final _$saveAsyncAction = AsyncAction('save');

  @override
  Future<bool> save(String title) {
    return _$saveAsyncAction.run(() => super.save(title));
  }

  final _$_BoxSettingsControllerBaseActionController =
      ActionController(name: '_BoxSettingsControllerBase');

  @override
  void setLang(String l) {
    final _$actionInfo =
        _$_BoxSettingsControllerBaseActionController.startAction();
    try {
      return super.setLang(l);
    } finally {
      _$_BoxSettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCompartments(double v) {
    final _$actionInfo =
        _$_BoxSettingsControllerBaseActionController.startAction();
    try {
      return super.setCompartments(v);
    } finally {
      _$_BoxSettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'langs: ${langs.toString()},lang: ${lang.toString()},isLoading: ${isLoading.toString()},errorMessage: ${errorMessage.toString()},hasFormen: ${hasFormen.toString()},compartments: ${compartments.toString()},goback: ${goback.toString()},mustType: ${mustType.toString()},random: ${random.toString()},askForeign: ${askForeign.toString()},testCount: ${testCount.toString()},askLang: ${askLang.toString()}';
    return '{$string}';
  }
}
